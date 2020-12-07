library(tidyverse)
library(pdftools)
library(readxl)
library(janitor)


# Parse table  --------------------------

tabula_checks = function(path){

  info =   read_csv(path) %>%
    clean_names() %>%
    mutate(row_n = row_number())

  checks = info %>%
    mutate(check = ifelse(posicion_fin + 1 == lead(posicion_inicio) , TRUE, FALSE)) %>%
    filter(check == FALSE)

  return(checks)

}

tabula_checks("~/Downloads/tabula-Registro Hogar 2006.csv")

info_hogar = read_csv("~/Downloads/tabula-Registro Hogar 2006.csv") %>%
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

c11 = create_var("C11", 1, 80, 80,  "b, 1,6, 9")
sp_clase = create_var("SPCLASE",1,135,135, "b, 1,6, 9")


info_hogar %>%
  slice(1:47) %>%
  bind_rows(c11) -> bit1


info_hogar_clean = bind_rows(bit1,
          info_hogar %>%
            slice(48:82) %>%
            bind_rows(sp_clase)) %>% select(-row_n)



write_csv(info_hogar_clean, "documentation/ense06/Hogar-ENSE-2006/variables_registro_hogar_2006.csv")

# Parse labels --------------------------

hogar = pdftools::pdf_text(pdf = "documentation/ense06/Hogar-ENSE-2006/Registro Hogar 2006.pdf")

hogar_clean = strsplit(hogar, "\n")



test = hogar_clean %>%
  unlist() %>%
  tibble() %>%
  slice(102:1082)

colnames(test) = "var"


parse_ense_06 = function(df){

  test2 = df %>%
  mutate(var = gsub("??? ", "", var),
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

return(test4)

}

test_ense06 = parse_ense_06(test)


# Get the variable
x = read_csv( "documentation/ense06/Hogar-ENSE-2006/variables_registro_hogar_2006.csv")
setdiff(unique(x$variable), unique(test4$nombre))
setdiff(unique(test4$nombre), unique(x$variable))


x = x %>%
  mutate(variable = ifelse(variable == "PROV *", "PROV",
                           ifelse(variable == "TRIM *", "TRIM",
                                  ifelse(variable == "CNI??O", "CNINO", variable))))


prueba = test4 %>%
  select(-longitud) %>%
  full_join(., x , by = c("nombre" = "variable")) %>%
  arrange(posicion_inicio) %>%
  mutate(contenido = str_to_lower(contenido),
    contenido = ifelse(nombre == lag(nombre) & str_detect(contenido, "aporta"),
                            paste(lag(contenido), contenido, sep = " "), contenido)) %>%
  group_by(nombre) %>%
  mutate(char_count = str_count(contenido)) %>%
  filter(char_count == max(char_count)) %>%
  mutate(contenido = str_to_sentence(contenido))




prueba = prueba %>%
  select(campo = nombre,
         longitud, posicion_inicio, posicion_final = posicion_fin,
         descripcion_del_campo = contenido, valores_validos)


write_csv(prueba, "documentation/ense06/Hogar-ENSE-2006/hogar_2006_info.csv")

# Label ----------------------------------

parse_ense_06_labels = function(df){

test_labels = test %>%
  mutate(var = gsub("??? ", "", var),
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


labels = test_labels %>%
  filter(type_var == "valores") %>%
  select(var_clean, cont_clean) %>%
  mutate(cont_clean = str_trim(cont_clean, "both"),
         cont_clean = str_to_sentence(cont_clean)) %>%
  filter(cont_clean != "") %>%
  rename(variable_ine = var_clean, valores_ine = cont_clean)

return(labels)

}

hogar_labels = parse_ense_06_labels(test)

write_csv(hogar_labels, "documentation/ense06/Hogar-ENSE-2006/hogar_2006_labels.csv")

