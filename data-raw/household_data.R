## code to prepare `household_19`, household_19_info and household_19_label, dataset goes here


library(tidyverse)
library(readxl)
library(janitor)


source("funs/funs_data.R")


# Load raw data -----------------------------------------

# ENSE 2017


household_17 <- read_excel("documentation/ense17/Hogar_ENSE17/Diseno registro HOGAR ENSE 2017_PUBLICACION.xlsx", range = "A9:E99")  %>%
  janitor::clean_names()

house_17_labels = read_excel("documentation/ense17/Hogar_ENSE17/Diseno registro HOGAR ENSE 2017_PUBLICACION.xlsx", sheet = 2, range = "A8:C467")

# ENSE 2012

household_12 = read_excel("documentation/ense12/disreg_ensalud12/DISENO HOGAR ENSE 2011-2012.xls", range = "A10:E105") %>%  janitor::clean_names()

house_12_labels = read_excel("documentation/ense12/disreg_ensalud12/DISENO HOGAR ENSE 2011-2012.xls", sheet = 2, range = "A9:C480" )





# Household info -----------------------

household_19_info = parse_info(household_17, variable_ine)

household_12_info = parse_info(household_12, campo)



# Household labels -------------------

household_19_labels = parse_labels(house_17_labels)

household_12_labels = parse_labels(house_12_labels)



# Load microdata


household_19 = parse_microdata(household_19_info, "documentation/ense17/Hogar_ENSE17/MICRODAT.CH.txt")


household_12 = parse_microdata(household_12_info, "datos_ensalud12/MICRODATO HOGAR ANONIMIZADO.txt")

usethis::use_data( household_19, household_19_info, household_19_labels,
                   household_12, household_12_info, household_12_labels,
                   overwrite = T)
