## code to prepare `children_19`  and children_19_info dataset goes here

library(tidyverse)
library(readxl)
library(janitor)

# Functions --------------------------------------------------------

children_info = function(df, filter_var){

  df %>%
    filter(!is.na({{ filter_var }})) %>%
    mutate(tipo_variable =  ifelse(is.na(longitud), {{ filter_var }}, NA)) %>%
    fill(tipo_variable, .direction = "down") %>%
    filter(!is.na(longitud), longitud != "LONGITUD") %>%
    mutate_at(vars(posicion_inicio, posicion_final, longitud), list(as.numeric))



}


children_labels = function(df){

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

parse_microdata =  function(df, path){

  x = readr::read_fwf(file = path,
                      skip = 0,
                      fwf_positions(df[[3]], df[[4]], df[[1]]))

  return(x)


}


# Load raw data ---------------------------------------------

# ENSE 19


children_17 <- read_excel("Menores_ENSE17/Diseno registro MENOR ENSE 2017_PUBLICACION.xls", range = "A9:E372")  %>%
  janitor::clean_names()

children_17_labels = read_excel("Menores_ENSE17/Diseno registro MENOR ENSE 2017_PUBLICACION.xls", sheet = 2, range = "A7:C2228")



# ENSE 12


children_11 <- read_excel("disreg_ensalud12/DISENO MENORES ENSE 2011-2012.xls", sheet = 1,  range = "A10:E387")  %>%
  janitor::clean_names()


children_11_labels = read_excel("disreg_ensalud12/DISENO MENORES ENSE 2011-2012.xls", sheet = 2, range = "A9:C2167")


# Children info ---------------------------


children_19_info = children_info(children_17, variable_ine)

children_12_info = children_info(children_11, campo)




# Children labels ---------------------------


children_19_labels = children_labels(children_17_labels)

children_12_labels = children_labels(children_11_labels)




# Load microdata


children_19 = parse_microdata(children_19_info, path = "Menores_ENSE17/MICRODAT.CM.txt" )

children_12 = parse_microdata(children_12_info, path = "datos_ensalud12/MICRODATO MENOR ANONIMIZADO.txt")


usethis::use_data(children_19, children_19_info, children_19_labels, children_12, children_12_info, children_12_labels, overwrite = T)
