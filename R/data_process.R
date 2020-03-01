# Clean datasets

library(tidyverse)
library(readxl)
library(janitor)



info_adults <- read_excel("Adultos_2017/Dise??o registro ADULTO ENSE 2017_PUBLICACIa??N.xlsx")

names(info_adults) = info_adults[6, ]

info_adults = info_adults %>% janitor::clean_names()

test = info_adults %>%
  filter(!is.na(variable_ine), variable_ine != "VARIABLE INE") %>%
  mutate(tipo_variable = ifelse(is.na(longitud), variable_ine, NA),
         modulo = ifelse(str_detect(tipo_variable, "^M??DULO"), tipo_variable, NA)) %>%
  fill(tipo_variable, .direction = "down") %>%
  fill(modulo, .direction = "down") %>%
  filter(!is.na(longitud), longitud != "LONGITUD")

test = test %>% mutate_at(vars(posicion_inicio, posicion_final, longitud), funs(as.numeric))




# Load microdata

adults = readr::read_fwf(file = "MICRODAT.CA.txt",
                  skip = 0,
                  #fwf_widths(test$longitud, test$variable_ine),
                  fwf_positions(test$posicion_inicio, test$posicion_final, test$variable_ine))



