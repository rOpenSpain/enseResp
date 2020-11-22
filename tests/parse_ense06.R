# Parse information Adults 2006
# -----------------------------


library(tidyverse)
library(readxl)
library(janitor)


source("funs/funs_data.R")


# Info parsed with tabula
info_adultos = read_csv("~/Downloads/tabula-Registro Adultos 2006-3.csv") %>%
  clean_names() %>%
  filter(!is.na(valores_validos)) %>%
  mutate(row_n = row_number())

# Some variables not parsed. Test to check those

info_adults_clean %>%
  mutate(check = ifelse(posicion_fin + 1 == lead(posicion_inicio) , TRUE, FALSE)) %>%
  filter(check == FALSE)


# Add missing vars
id =  tibble(variable = "NIDENTIF",
                longitud = 7,
                posicion_inicio  =  12,
                posicion_fin = 18 ,
                valores_validos = "")

factor_df = tibble(variable = "FACTOR",
                   longitud = 11,
                   posicion_inicio  =  835,
                   posicion_fin = 845 ,
                   valores_validos = "")


clase =  tibble(variable = "ASCLASE",
                longitud = 1,
                posicion_inicio  =  848,
                posicion_fin = 848 ,
                valores_validos = c("1 a 6,9"))

# Bind variables
info_adultos  %>%
  slice(1:6) %>%
  bind_rows(id) -> bit1

info_adultos %>%
  slice(7:605) %>%
  bind_rows(factor_df) -> bit2

info_adultos %>%
  slice(606:607) %>%
  bind_rows(clase) -> bit3

info_adultos %>%
  slice(608:616) -> bit4

info_adults_clean = bind_rows(bit1, bit2, bit3, bit4) %>% select(-row_n)




write_csv(info_adults_clean, "documentation/ense06/Adulto-ENSE-2006/variables_registro_adultos_2006.csv")

# Parse pdf for info ------------------------------

library(pdftools)

registro = pdftools::pdf_text(pdf = "documentation/ense06/Adulto-ENSE-2006/Registro Adultos 2006.pdf")

registro_clean = strsplit(registro, "\n")

test = registro_clean %>% unlist() %>% tibble()

colnames(test) = "var"


test2 = test %>%
  slice(636:5627) %>%
  mutate(variable = ifelse(str_detect(var, "^??? NOMBRE DE LA VARIABLE"), var,
                           ifelse(str_detect(var, "CONTENIDO = "), var,
                                  ifelse(str_detect(var, "LONGITUD = "), var,
                                         ifelse(str_detect(var, "VALORES Y SIGNIFICADO"), var, NA))))) %>%
  mutate(var_clean = ifelse(str_detect(var, "^??? NOMBRE DE LA VARIABLE"), var, NA),
         var_clean = gsub("??? NOMBRE DE LA VARIABLE = ", "", var_clean)) %>%
  fill(var_clean, .direction = "down")



test3 = test2 %>%
  mutate(check = ifelse(str_detect(variable, "CONTENIDO = ") & is.na(lead(variable)), TRUE, FALSE),
         check2 = ifelse(lag(check) == TRUE, "Y", NA),
         cont_clean = ifelse(check == TRUE, paste(variable, lead(var), sep = " "), NA)) %>%
  filter(is.na(check2)) %>%
  select(-check, -check2) %>%
  mutate(type_var = ifelse(str_detect(var, "^??? NOMBRE DE LA VARIABLE"), "nombre",
                           ifelse(str_detect(var, "CONTENIDO = "), "contenido",
                                  ifelse(str_detect(var, "LONGITUD = "), "longitud",
                                         ifelse(str_detect(var, "VALORES Y SIGNIFICADO"), "valores", NA))))) %>%
  fill(type_var, .direction = "down") %>%
  mutate(cont_clean = ifelse(is.na(cont_clean), var, cont_clean),
         cont_clean = str_remove_all(cont_clean, paste(c("??? NOMBRE DE LA VARIABLE = ",
                                                         "CONTENIDO = ",
                                                         "LONGITUD = ",
                                                         "VALORES Y SIGNIFICADO"), collapse = "|")),
         cont_clean = ifelse(type_var != "nombre", str_to_sentence(cont_clean), cont_clean))



test4 = test3 %>%
  select(var_clean, type_var, cont_clean) %>%
  filter(type_var != "valores") %>%
  pivot_wider(names_from = type_var, values_from = cont_clean) %>%
  select(nombre, contenido, longitud) %>%
  unnest(c(nombre, contenido, longitud))




# Get the variable
x = read_csv( "documentation/ense06/Adulto-ENSE-2006/variables_registro_adultos_2006.csv")
setdiff(unique(x$variable), unique(test4$nombre))
setdiff(unique(test4$nombre), unique(x$variable))



x = x %>%
  mutate(variable = gsub("K", "J", variable),
         variable = ifelse(variable == "PROV *", "PROV",
                           ifelse(variable == "TRIM *", "TRIM", variable)))

setdiff(unique(x$variable), unique(test4$nombre))




prueba = test4 %>%
  select(-longitud) %>%
  full_join(., x , by = c("nombre" = "variable")) %>%
  arrange(posicion_inicio) %>%
  mutate(contenido = ifelse(posicion_inicio == 850 & lead(contenido) == "Sea ocupado)",
                            paste(contenido, lead(contenido), sep = " "), contenido)) %>%
  filter(contenido != "Sea ocupado)") %>%
  mutate(contenido = str_to_sentence(contenido))



prueba = prueba %>%
  select(campo = nombre,
         longitud, posicion_inicio, posicion_final = posicion_fin,
         descripcion_del_campo = contenido, valores_validos)

write_csv(prueba, "documentation/ense06/Adulto-ENSE-2006/adultos_2006_info.csv")

# Labels ----------------------------------

values = test3 %>%
  filter(type_var == "valores") %>%
  select(var_clean, cont_clean) %>%
  mutate(cont_clean = str_trim(cont_clean, "both"),
         cont_clean = str_to_sentence(cont_clean)) %>%
  filter(cont_clean != "") %>%
  rename(variable_ine = var_clean, valores_ine = cont_clean)


write_csv(values, "documentation/ense06/Adulto-ENSE-2006/adultos_2006_labels.csv")

