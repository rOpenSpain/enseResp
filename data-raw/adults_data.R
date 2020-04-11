## code to prepare `adults` dataset goes here

library(tidyverse)
library(readxl)
library(janitor)



# Functions ---------------------------------------------


adults_info = function(df, filter_var){

  df %>%
    filter(!is.na({{ filter_var }})) %>%
    mutate(tipo_variable =  ifelse(is.na(longitud), {{ filter_var }}, NA)) %>%
    fill(tipo_variable, .direction = "down") %>%
    filter(!is.na(longitud), longitud != "LONGITUD") %>%
  mutate_at(vars(posicion_inicio, posicion_final, longitud), list(as.numeric))



}

# Load raw data -----------------------------------------

# ENSE 2017

adults_17 <- read_excel("Adultos_2017/Diseno registro ADULTO ENSE 2017_PUBLICACION.xlsx", range = "A8:E611")  %>%
  janitor::clean_names()


# ENSE 2011

adults_11 <- read_excel("Adulto-ENSE-2011-12/DisenoAdultos.xls", range = "A10:E735")  %>%
  janitor::clean_names()



# Information on adults -----------------------------------

adults_19_info = adults_info(adults_17, variable_ine)

adults_12_info = adults_info(adults_11, campo)

# Load microdata ------------------------------------------

adults_19 = readr::read_fwf(file = "MICRODAT.CA.txt",
                            skip = 0,
                            fwf_positions(adults_19_info$posicion_inicio, adults_19_info$posicion_final, adults_19_info$variable_ine))




adults_12 = readr::read_fwf(file = "Adulto-ENSE-2011-12/MicrodatoAdultos.txt",
                            skip = 0,
                            fwf_positions(adults_12_info$posicion_inicio, adults_12_info$posicion_final, adults_12_info$campo))



# Final datasets

usethis::use_data(adults_19, adults_19_info, adults_12, adults_12_info, overwrite = T)







