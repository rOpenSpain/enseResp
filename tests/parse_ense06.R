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


