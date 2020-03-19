## code to prepare `household_19`  and household_19_info dataset goes here

library(tidyverse)
library(readxl)
library(janitor)


info_household <- read_excel("Hogar_ENSE17/Diseno registro HOGAR ENSE 2017_PUBLICACION.xlsx", range = "A9:E99")  %>%
  janitor::clean_names()


household_info_final = info_household %>%
  filter(!is.na(variable_ine), variable_ine != "VARIABLE INE") %>%
  mutate(tipo_variable = ifelse(is.na(longitud), variable_ine, NA)) %>%
  fill(tipo_variable, .direction = "down") %>%
  filter(!is.na(longitud), longitud != "LONGITUD") %>%
  mutate(tipo_variable = ifelse(is.na(tipo_variable), "PROTOCOLO DE LA ENTREVISTA", tipo_variable))


household_19_info = household_info_final %>%
  mutate_at(vars(posicion_inicio, posicion_final, longitud), list(as.numeric))


# Load microdata

household_19 = readr::read_fwf(file = "Hogar_ENSE17/MICRODAT.CH.txt",
                              skip = 0,
                              #fwf_widths(adults_info_final$longitud, adults_info_final$variable_ine),
                              fwf_positions(household_19_info$posicion_inicio, household_19_info$posicion_final, household_19_info$variable_ine))

usethis::use_data(household_19, household_19_info, overwrite = T)
