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


info_infantil_clean = bind_rows(bit1, bit2, bit3, bit4, bit5, bit6, bit7) %>% select(-row_n)


write_csv(info_infantil_clean, "documentation/ense06/Infantil-ENSE-2006/variables_registro_infantil_2006.csv")



infantil = pdftools::pdf_text(pdf = "documentation/ense06/Infantil-ENSE-2006/Registro Menores 2006.pdf")

infantil_clean = strsplit(infantil, "\n")

test= infantil_clean %>%
  unlist() %>%
  tibble() %>%
  slice(11:362)

colnames(test) = "var"

test_clean = test %>%
  filter(var != "* Datos no accesibles en el archivo de texto.") %>%
  separate(var, c("VARIABLE",  "LONGITUD", "INICIO", "FIN", "VALORES V??LIDOS"), sep = " ")
