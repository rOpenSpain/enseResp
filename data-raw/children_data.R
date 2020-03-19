## code to prepare `children_19`  and children_19_info dataset goes here

library(tidyverse)
library(readxl)
library(janitor)


info_children <- read_excel("Menores_ENSE17/Diseno registro MENOR ENSE 2017_PUBLICACION.xls", range = "A9:E372")  %>%
  janitor::clean_names()


children_info_final = info_children %>%
  filter(!is.na(variable_ine), variable_ine != "VARIABLE INE") %>%
  mutate(tipo_variable = ifelse(is.na(longitud), variable_ine, NA)) %>%
  fill(tipo_variable, .direction = "down") %>%
  filter(!is.na(longitud), longitud != "LONGITUD") %>%
  mutate(tipo_variable = ifelse(is.na(tipo_variable), "DATOS DE IDENTIFICACION", tipo_variable))

children_19_info = children_info_final %>%
  mutate_at(vars(posicion_inicio, posicion_final, longitud), list(as.numeric))




# Load microdata

children_19 = readr::read_fwf(file = "Menores_ENSE17/MICRODAT.CM.txt",
                            skip = 0,
                            #fwf_widths(adults_info_final$longitud, adults_info_final$variable_ine),
                            fwf_positions(children_19_info$posicion_inicio, children_19_info$posicion_final, children_19_info$variable_ine))

usethis::use_data(children_19, children_19_info, overwrite = T)
