parse_info = function(df, filter_var){

  x = df %>%
    filter(!is.na({{ filter_var }})) %>%
    mutate(tipo_variable =  ifelse(is.na(longitud), {{ filter_var }}, NA)) %>%
    fill(tipo_variable, .direction = "down") %>%
    filter(!is.na(longitud), longitud != "LONGITUD") %>%
    mutate_at(vars(posicion_inicio, posicion_final, longitud), list(as.numeric))

  return(x)


}


parse_labels =  function(df){

  x = df %>%
    rename(var1 = `...1`,
           var2 = `...2`,
           var3 = `...3`) %>%
    mutate(var4  = ifelse(var1 == "Variable" | var1 == "Variable:" | var1 == "Contenido" & !is.na(var2) & is.na(lag(var2)), var2, NA),
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
