## code to prepare `adults` dataset goes here

library(tidyverse)
library(readxl)
library(janitor)




info_adults <- read_excel("Adultos_2017/Diseno registro ADULTO ENSE 2017_PUBLICACION.xlsx", range = "A8:E611")  %>%
  janitor::clean_names()

names(info_adults) = info_adults[6, ]


adults_info_final = info_adults %>%
  filter(!is.na(variable_ine), variable_ine != "VARIABLE INE") %>%
  mutate(tipo_variable = ifelse(is.na(longitud), variable_ine, NA),
         modulo = ifelse(str_detect(tipo_variable, "^M??DULO"), tipo_variable, NA)) %>%
  fill(tipo_variable, .direction = "down") %>%
  fill(modulo, .direction = "down") %>%
  filter(!is.na(longitud), longitud != "LONGITUD")


adults_19_info = adults_info_final %>%
  mutate_at(vars(posicion_inicio, posicion_final, longitud), list(as.numeric))


adult_info = adults_info_final %>%
  select(variable_ine, descripcion_del_campo, tipo_variable, modulo)


# Load microdata

adults_19 = readr::read_fwf(file = "MICRODAT.CA.txt",
                         skip = 0,
                         fwf_positions(adults_info_final$posicion_inicio, adults_info_final$posicion_final, adults_info_final$variable_ine))




usethis::use_data(adults_19, adults_19_info, overwrite = T)

# Final datasets



