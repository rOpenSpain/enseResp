#' Get variables per Spanish region (comunidad autonoma)
#'
#' @description This function provides information of the survey regarding particular regions.
#' @param region Character string. Include the name of the region in lower case.
#'  It accepts the following names: andalucia, aragon, asturias, baleares, canarias, cantabria,
#'  castilla_leon, castilla la mancha, cataluna, comunidad valenciana, extremadura, galicia, madrid,
#'  murcia, navarra, pais vasco, rioja, ceuta, melilla
#' @keywords regions
#' @examples
#' get_region(adult, region = 'madrid')
#' get_region(adult, region = 'castilla_mancha')
#'




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
  } else if (region == "castilla leon") {
    region <- "07"
  } else if (region == "castilla la mancha") {
    region <- "08"
  } else if (region == c("cataluna")) {
    region <- "09"
  } else if (region == "comunidad valenciana") {
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
  } else if (region == "pais vasco") {
    region <- "16"
  } else if (region == "rioja") {
    region <- "17"
  } else if (region == "ceuta") {
    region <- "18"
  } else if (region == "melilla") {
    region <- "19"
  } else {stop("Correct spelling?")}

  y = df %>% filter(CCAA %in% region)

  return(y)

}



