## code to prepare `children_19`  and children_19_info dataset goes here

library(tidyverse)
library(readxl)
library(janitor)


source("funs/funs_data.R")


# Load raw data ---------------------------------------------

# ENSE 19


children_17 <- read_excel("documentation/ense17/Menores_ENSE17/Diseno registro MENOR ENSE 2017_PUBLICACION.xls", range = "A9:E372")  %>%
  janitor::clean_names()

children_17_labels = read_excel("documentation/ense17/Menores_ENSE17/Diseno registro MENOR ENSE 2017_PUBLICACION.xls", sheet = 2, range = "A7:C2228")



# ENSE 12


children_11 <- read_excel("documentation/ense12/disreg_ensalud12/DISENO MENORES ENSE 2011-2012.xls", sheet = 1,  range = "A10:E387")  %>%
  janitor::clean_names()


children_11_labels = read_excel("documentation/ense12/disreg_ensalud12/DISENO MENORES ENSE 2011-2012.xls", sheet = 2, range = "A9:C2167")


# Children info ---------------------------


children_19_info = parse_info(children_17, variable_ine)

children_12_info = parse_info(children_11, campo)




# Children labels ---------------------------


children_19_labels = parse_labels(children_17_labels)

children_12_labels = parse_labels(children_11_labels)




# Load microdata


children_19 = parse_microdata(children_19_info, path = "Menores_ENSE17/MICRODAT.CM.txt" )

children_12 = parse_microdata(children_12_info, path = "datos_ensalud12/MICRODATO MENOR ANONIMIZADO.txt")


usethis::use_data(children_19, children_19_info, children_19_labels, children_12, children_12_info, children_12_labels, overwrite = T)
