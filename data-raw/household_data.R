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


# ENSE 2006

household_06 = read_csv("documentation/ense06/Hogar-ENSE-2006/hogar_2006_info.csv")

house_06_labels = read_csv("documentation/ense06/Hogar-ENSE-2006/hogar_2006_labels.csv")




# Household info -----------------------

household_19_info = parse_info(household_17, variable_ine)

household_12_info = parse_info(household_12, campo)

household_06_info = parse_info(household_06, campo)



# Household labels -------------------

household_19_labels = parse_labels(house_17_labels)

household_12_labels = parse_labels(house_12_labels)



# Load microdata


household_19 = parse_microdata(household_19_info, "documentation/ense17/Hogar_ENSE17/MICRODAT.CH.txt")


household_12 = parse_microdata(household_12_info, "datos_ensalud12/MICRODATO HOGAR ANONIMIZADO.txt")


household_06 = parse_microdata(household_06_info, path = "documentation/ense06/Hogar-ENSE-2006/HOGAR06.txt" )



usethis::use_data( household_19, household_19_info, household_19_labels,
                   household_12, household_12_info, household_12_labels,
                   household_06, household_06_info, house_06_labels,
                   overwrite = T)


