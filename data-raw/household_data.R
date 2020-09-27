## code to prepare `household_19`, household_19_info and household_19_label, dataset goes here

library(tidyverse)
library(readxl)
library(janitor)

# Functions ------------------------------------------------

house_info = function(df, filter_var){

  df %>%
    filter(!is.na({{ filter_var }})) %>%
    mutate(tipo_variable =  ifelse(is.na(longitud), {{ filter_var }}, NA)) %>%
    fill(tipo_variable, .direction = "down") %>%
    filter(!is.na(longitud), longitud != "LONGITUD") %>%
    mutate_at(vars(posicion_inicio, posicion_final, longitud), list(as.numeric))


}


house_labels = function(df){

  x = df %>%
    rename(var1 = `...1`,
           var2 = `...2`,
           var3 = `...3`) %>%
    mutate(var4  = ifelse(var1 == "Variable" | var1 == "Variable:" & !is.na(var2), var2, NA),
           var4 = ifelse(var2 == "CLASE_PR", "CLASE_PR", var4 )) %>%
    fill(var4, .direction = "down") %>%
    filter(!is.na(var2) & var1 == "Valores"  | var1 == "Valores:"  | is.na(var1)) %>%
    mutate(var5 = ifelse(is.na(var1) & is.na(var2) & is.na(var3) & !is.na(var4), TRUE, FALSE )) %>%
    filter(var5 == FALSE) %>%
    select(valores_ine = var2, valores = var3, variable_ine = var4)

  return(x)

}




# Load raw data -----------------------------------------

# ENSE 2017


household_17 <- read_excel("Hogar_ENSE17/Diseno registro HOGAR ENSE 2017_PUBLICACION.xlsx", range = "A9:E99")  %>%
  janitor::clean_names()

house_17_labels = read_excel("Hogar_ENSE17/Diseno registro HOGAR ENSE 2017_PUBLICACION.xlsx", sheet = 2, range = "A8:C467")



# Information

household_19_info = house_info(household_17, variable_ine)

household_19_labels = house_labels(house_17_labels)




# Load microdata

household_19 = readr::read_fwf(file = "Hogar_ENSE17/MICRODAT.CH.txt",
                              skip = 0,
                              #fwf_widths(adults_info_final$longitud, adults_info_final$variable_ine),
                              fwf_positions(household_19_info$posicion_inicio, household_19_info$posicion_final, household_19_info$variable_ine))

usethis::use_data( household_19, household_19_info, household_19_labels, overwrite = T)
