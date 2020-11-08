## code to prepare `adults` dataset goes here

library(tidyverse)
library(readxl)
library(janitor)

source("funs/funs_data.R")

# Functions ---------------------------------------------


adults_info = function(df, filter_var){

  df %>%
    filter(!is.na({{ filter_var }})) %>%
    mutate(tipo_variable =  ifelse(is.na(longitud), {{ filter_var }}, NA)) %>%
    fill(tipo_variable, .direction = "down") %>%
    filter(!is.na(longitud), longitud != "LONGITUD") %>%
  mutate_at(vars(posicion_inicio, posicion_final, longitud), list(as.numeric))



}

adults_labels = function(df){

  x = df %>%
    rename(var1 = `...1`,
           var2 = `...2`,
           var3 = `...3`) %>%
    mutate(var4  = ifelse(var1 == "Variable" | var1 == "Variable:" & !is.na(var2), var2, NA)) %>%
    fill(var4, .direction = "down") %>%
    filter(!is.na(var2) & var1 == "Valores"  | var1 == "Valores:"  | is.na(var1)) %>%
    mutate(var5 = ifelse(is.na(var1) & is.na(var2) & is.na(var3) & !is.na(var4), TRUE, FALSE )) %>%
    filter(var5 == FALSE) %>%
    select(valores_ine = var2, valores = var3, variable_ine = var4)

  return(x)

}

parse_microdata =  function(df, path){

  x = readr::read_fwf(file = path,
                      skip = 0,
                      fwf_positions(df[[3]], df[[4]], df[[1]]))

  return(x)


}




# Load raw data -----------------------------------------

# ENSE 2017

adults_17 <- read_excel("Adultos_2017/Diseno registro ADULTO ENSE 2017_PUBLICACION.xlsx", range = "A8:E611")  %>%
  janitor::clean_names()


adults_17_labels = read_excel("Adultos_2017/Diseno registro ADULTO ENSE 2017_PUBLICACION.xlsx", sheet = 2, range = "A8:C3772")


# ENSE 2011

adults_11 <- read_excel("Adulto-ENSE-2011-12/DisenoAdultos.xls", range = "A10:E735")  %>%
  janitor::clean_names()

adults_11_labels = read_excel("Adulto-ENSE-2011-12/DisenoAdultos.xls", sheet = 2,  range = "A9:C4531")


# ENSE 2006

adults_06_info = read_csv("documentation/ense06/Adulto-ENSE-2006/variables_registro_adultos_2006.csv")


# Information on adults info -----------------------------------

adults_19_info = adults_info(adults_17, variable_ine)

adults_12_info = adults_info(adults_11, campo)

# Information on adults labels -----------------------------------

adults_19_labels = adults_labels(adults_17_labels)

adults_12_labels = adults_labels(adults_11_labels)

# Load microdata ------------------------------------------

adults_19 = readr::read_fwf(file = "MICRODAT.CA.txt",
                            skip = 0,
                            fwf_positions(adults_19_info$posicion_inicio, adults_19_info$posicion_final, adults_19_info$variable_ine))




adults_12 = readr::read_fwf(file = "Adulto-ENSE-2011-12/MicrodatoAdultos.txt",
                            skip = 0,
                            fwf_positions(adults_12_info$posicion_inicio, adults_12_info$posicion_final, adults_12_info$campo))



adults_06 = parse_microdata(adults_06_info, "documentation/ense06/Adulto-ENSE-2006/ADULTO06.txt")

# Final datasets

usethis::use_data(adults_19, adults_19_info, adults_19_labels, adults_12, adults_12_info, adults_12_labels, overwrite = T)

usethis::use_data(adults_06)





