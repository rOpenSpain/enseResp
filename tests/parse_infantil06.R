library(tidyverse)
library(pdftools)
library(readxl)
library(janitor)

 # Parse INFANTIL
source("funs/funs_data.R")



tabula_checks = function(path){

  info =   read_csv(path) %>%
    clean_names() %>%
    mutate(row_n = row_number())

  checks = info %>%
    mutate(check = ifelse(posicion_fin + 1 == lead(posicion_inicio) , TRUE, FALSE)) %>%
    filter(check == FALSE)

  return(checks)

}

# vars that may not be taken
tabula_checks("~/Downloads/tabula-Registro Menores 2006.csv")

info_infantil = read_csv("~/Downloads/tabula-Registro Menores 2006.csv") %>%
  clean_names() %>%
  mutate(row_n = row_number())

create_var =  function(var, long, start, end, values){
  x = tibble(variable = var,
             longitud = long,
             posicion_inicio  = start,
             posicion_fin = end ,
             valores_validos = values)

return(x)
}

# missing vars ------------------------

a2_7b = create_var("A2_7B", 1, 75, 75,  "b, 1,6, 9")
c13_4b = create_var("C13_4B", 1, 194, 194,  "b, 1,0, 9")
e15_2 = create_var("E15_2", 1, 245, 245,  "b, 1,2,3, 9")
f1_26_4c = create_var("F1_26_4C", 2, 315, 316,  "b,00a30,98,99")
f5_46 = create_var("F5_46", 1, 381, 381,  "1,6, 9")
g2_71_7 = create_var("G2_71_7", 1, 451, 451,  "b,1 a 5,9")
msimc = create_var("MSIMC", 1, 528, 528,  "b,1, 2,3,9")

# info_infantil
info_infantil %>%
  slice(1:47) %>%
  bind_rows(a2_7b) -> bit1

info_infantil %>%
  slice(48:97) %>%
  bind_rows(c13_4b) -> bit2

info_infantil %>%
  slice(98:147) %>%
  bind_rows(e15_2) -> bit3

info_infantil %>%
  slice(148:197) %>%
  bind_rows(f1_26_4c) -> bit4


info_infantil %>%
  slice(198:247) %>%
  bind_rows(f5_46) -> bit5

info_infantil %>%
  slice(248:297) %>%
  bind_rows(g2_71_7) -> bit6


info_infantil %>%
  slice(298:343) -> bit7




info_infantil_clean = bind_rows(bit1, bit2, bit3, bit4, bit5, bit6, bit7, msimc) %>% select(-row_n)


write_csv(info_infantil_clean, "documentation/ense06/Infantil-ENSE-2006/variables_registro_infantil_2006.csv")

# Parse labels --------------------------
infantil = pdftools::pdf_text(pdf = "documentation/ense06/Infantil-ENSE-2006/Registro Menores 2006.pdf")

infantil_clean = strsplit(infantil, "\n")




test = infantil_clean %>%
  unlist() %>%
  tibble()%>%
  slice(367:3168)

colnames(test) = "var"




test2 = test %>%
  mutate(var = gsub("• ", "", var),
         var = str_trim(var, "left")) %>%
  mutate(variable = ifelse(str_detect(var, "NOMBRE DE LA VARIABLE"), var,
                           ifelse(str_detect(var, "CONTENIDO = "), var,
                                  ifelse(str_detect(var, "LONGITUD = "), var,
                                         ifelse(str_detect(var, "VALORES Y SIGNIFICADO"), var, NA))))) %>%
  mutate(var_clean = ifelse(str_detect(var, "NOMBRE DE LA VARIABLE"), var, NA),
         var_clean = gsub("NOMBRE DE LA VARIABLE = ", "", var_clean)) %>%
  fill(var_clean, .direction = "down") %>%
  mutate(check = ifelse(str_detect(variable, "CONTENIDO = ") & is.na(lead(variable)), TRUE, FALSE),
         check2 = ifelse(lag(check) == TRUE, "Y", NA),
         cont_clean = ifelse(check == TRUE, paste(variable, lead(var), sep = " "), NA)) %>%
  filter(is.na(check2)) %>%
  select(-check, -check2) %>%
  mutate(type_var = ifelse(str_detect(var, "NOMBRE DE LA VARIABLE"), "nombre",
                           ifelse(str_detect(var, "CONTENIDO = "), "contenido",
                                  ifelse(str_detect(var, "LONGITUD = "), "longitud",
                                         ifelse(str_detect(var, "VALORES Y SIGNIFICADO"), "valores", NA))))) %>%
  fill(type_var, .direction = "down") %>%
  mutate(cont_clean = ifelse(is.na(cont_clean), var, cont_clean),
         cont_clean = str_remove_all(cont_clean, paste(c("NOMBRE DE LA VARIABLE = ",
                                                         "CONTENIDO = ",
                                                         "LONGITUD = ",
                                                         "VALORES Y SIGNIFICADO"), collapse = "|")),
         cont_clean = ifelse(type_var != "nombre", str_to_sentence(cont_clean), cont_clean))




test4 = test2 %>%
  select(var_clean, type_var, cont_clean) %>%
  filter(type_var != "valores") %>%
  pivot_wider(names_from = type_var, values_from = cont_clean) %>%
  select(nombre, contenido, longitud) %>%
  unnest(c(nombre, contenido, longitud))




# Get the variable
x = read_csv( "documentation/ense06/Infantil-ENSE-2006/variables_registro_infantil_2006.csv")
setdiff(unique(x$variable), unique(test4$nombre))
setdiff(unique(test4$nombre), unique(x$variable))


x = x %>%
  mutate(variable = ifelse(variable == "PROV *", "PROV",
                           ifelse(variable == "TRIM *", "TRIM",
                                  ifelse(variable == "G2_62_0", "G1_62_0",
                                         ifelse(variable == "G2_69", "G1_69",
                           ifelse(variable == "TRIM *", "TRIM", variable))))))


setdiff(unique(x$variable), unique(test4$nombre))


prueba = test4 %>%
  select(-longitud) %>%
  full_join(., x , by = c("nombre" = "variable")) %>%
  arrange(posicion_inicio) %>%
  mutate(contenido = str_to_sentence(contenido))


prueba = prueba %>%
  select(campo = nombre,
         longitud, posicion_inicio, posicion_final = posicion_fin,
         descripcion_del_campo = contenido, valores_validos)


write_csv(prueba, "documentation/ense06/Infantil-ENSE-2006/infantil_2006_info.csv")

# Labels ------------------

labels = test2 %>%
  filter(type_var == "valores") %>%
  select(var_clean, cont_clean) %>%
  mutate(cont_clean = str_trim(cont_clean, "both"),
         cont_clean = str_to_sentence(cont_clean)) %>%
  filter(cont_clean != "") %>%
  rename(variable_ine = var_clean, valores_ine = cont_clean)

write_csv(labels, "documentation/ense06/Infantil-ENSE-2006/infantil_2006_labels.csv")

