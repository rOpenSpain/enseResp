## code to prepare `adults` dataset goes here

library(tidyverse)
library(readxl)
library(janitor)



info_adults <- read_excel("Adults_2017/Dise??o registro ADULTO ENSE 2017_PUBLICACIa??N.xlsx")

names(info_adults) = info_adults[6, ]

info_adults = info_adults %>% janitor::clean_names()

adults_info_final = info_adults %>%
  filter(!is.na(variable_ine), variable_ine != "VARIABLE INE") %>%
  mutate(tipo_variable = ifelse(is.na(longitud), variable_ine, NA),
         modulo = ifelse(str_detect(tipo_variable, "^M??DULO"), tipo_variable, NA)) %>%
  fill(tipo_variable, .direction = "down") %>%
  fill(modulo, .direction = "down") %>%
  filter(!is.na(longitud), longitud != "LONGITUD")

adults_info_final = adults_info_final %>%
  mutate_at(vars(posicion_inicio, posicion_final, longitud), funs(as.numeric))


adult_info = adults_info_final %>%
  select(variable_ine, descripcion_del_campo, tipo_variable, modulo)


# Load microdata

adults = readr::read_fwf(file = "MICRODAT.CA.txt",
                         skip = 0,
                         fwf_positions(adults_info_final$posicion_inicio, adults_info_final$posicion_final, adults_info_final$variable_ine))




# Final datasets


usethis::use_data(adults, adult_info, overwrite = T)


