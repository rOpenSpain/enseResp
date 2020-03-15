#' Get variables per Spanish region (comunidad aut??noma)
#'
#' @description This function provides information of the survey regarding particular regions.
#' @param region Character string. Include the name of the region in lower case.
#'  It accepts the following names: andalucia, aragon, asturias, baleares, canarias, cantabria,
#'  castilla_leon, castilla_mancha, cataluna, comunidad valenciana, extremadura, galicia, madrid,
#'  murcia, navarra, pais vasco, rioja, ceuta, melilla
#' @keywords regions
#' @examples
#' get_region(adult, region = 'madrid')
#' get_region(adult, region = 'castilla_mancha')
#'
#' dogs_over_cats()

get_region = function(df, region){

  if (region == "andalucia") {
    region <- "01"
  } else if (region == "aragon") {
    region <- "02"
  } else if (region == "asturias") {
    region <- "03"
  } else if (region == "baleares") {
    region <- "04"
  } else if (region == "canarias") {
    region <- "05"
  } else if (region == "cantabria") {
    region <- "06"
  } else if (region == "castilla_leon") {
    region <- "07"
  } else if (region == "castilla_mancha") {
    region <- "08"
  } else if (region == "cataluna") {
    region <- "09"
  } else if (region == "comunidad_valenciana") {
    region <- "10"
  } else if (region == "extremadura") {
    region <- "11"
  } else if (region == "galicia") {
    region <- "12"
  } else if (region == "madrid") {
    region <- "13"
  } else if (region == "murcia") {
    region <- "14"
  } else if (region == "navarra") {
    region <- "15"
  } else if (region == "pais_vasco") {
    region <- "16"
  } else if (region == "rioja") {
    region <- "17"
  } else if (region == "ceuta") {
    region <- "18"
  } else if (region == "melilla") {
    region <- "19"
  }
  y = df %>% filter(CCAA %in% region)
  return(y)

}



