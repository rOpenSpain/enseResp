#' Obtains data by the type of variable in the survey.
#' @description Obtains data by the type of variable in the
#'  survey. There are different types groups of variables that
#'  can be selected.
#'
#' @param type Defines the type of variable. Accepts the following strings:
#'  demographic: Demographic information of the user.
#'  economic_activity: Economic activity of the user.
#'  health: Health status of the user
#'  accidents: Likelihood of accidents of the user.
#'  activity_restriction: Restriction of activity in the user.
#'  limitations: Physical, mental and cognitive limitations of the user
#'  daily_limitations: Limitations in the daily activities of the user.
#'  mental: Mental health of the user.
#'  doctor: Health care and GP visits.
#'  hospital: Hospital visits, emergency wards and insurance.
#'  drugs: Drugs consumption.
#'  prevention: Prevention practices.
#'  lack: Non-covered medical needs.
#'  physical: Physical characteristics of the user.
#'  physical_activity: Physical activity of the user.
#'  nutrition: Nutrition of the user.
#'  dental: Dental health of the user.
#'  smoking: Smoking consumption and smoke exposure of the user.
#'  alcohol: Alcohol consumption of the user.
#'  support: Support and social life of the user.
#'  care: Care activities of the user.
#'  other: Other variables
#'


#' @examples
#' get_variable(adult, variable = "care")



get_variable = function(df, type){
require(dplyr)

  # Define sub dataframe
  vars_economic_activity = df %>%
    select(CCAA:ACTIVa, starts_with("F"), -FACTORADULTO)

  vars_demographic = df %>%
    select(CCAA:ACTIVa, starts_with("E"), NIVEST)

  vars_health = df %>%
    select(CCAA:ACTIVa, starts_with("G"))

  vars_accidents = df %>%
    select(CCAA:ACTIVa, starts_with("H"))

  vars_activity_restriction = df %>%
    select(CCAA:ACTIVa, starts_with("I"), -IMCa)

  vars_limitations = df %>%
    select(CCAA:ACTIVa, starts_with("K"))

  vars_daily_limitations = df %>%
    select(CCAA:ACTIVa, starts_with("L"))

  vars_mental = df %>%
    select(CCAA:ACTIVa, starts_with("M"))

  vars_doctor = df %>%
    select(CCAA:ACTIVa, starts_with("N"))

  vars_emergency = df %>%
    select(CCAA:ACTIVa, starts_with("O"))

  vars_drugs = df %>%
    select(CCAA:ACTIVa, starts_with("P"))

  vars_prevention = df %>%
    select(CCAA:ACTIVa, starts_with("Q"))

  vars_lack_medical = df %>%
    select(CCAA:ACTIVa, starts_with("R"))

  vars_physical = df %>%
    select(CCAA:ACTIVa, starts_with("S"))

  vars_physical_activity = df %>%
    select(CCAA:ACTIVa, starts_with("T"))

  vars_nutrition= df %>%
    select(CCAA:ACTIVa, starts_with("U"), -U2_120F)

  vars_dental = df %>%
    select(CCAA:ACTIVa, U2_120F)

  vars_smoking = df %>%
    select(CCAA:ACTIVa, starts_with("V"))

  vars_alcohol = df %>%
    select(CCAA:ACTIVa, starts_with("W"))

  vars_support = df %>%
    select(CCAA:ACTIVa, starts_with("X"))

  vars_care = df %>%
    select(CCAA:ACTIVa, starts_with("Y"))

  vars_other = df %>%
    select(CCAA:ACTIVa, FACTORADULTO,
           CLASE_PR, IMCa, CMD1,
           CMD2, CMD3)



  if(type == "demographic" )              {
    df_out <- vars_demographic
  } else if (type == "economic_activity") {
    df_out <- vars_economic_activity
  } else if (type == "health")             {
    df_out <- vars_health
  } else if (type == "accidents")          {
    df_out <- vars_accidents
  } else if (type == "activity_restriction") {
  df_out <- vars_activity_restriction
  } else if (type == "limitations")       {
    df_out <- vars_limitations
  } else if (type == "daily_limitations") {
    df_out <- vars_daily_limitations
  } else if (type == "mental") {
    df_out <- vars_mental
  } else if (type == "doctor") {
    df_out <- vars_doctor
  } else if (type == "hospital") {
    df_out <- vars_hospital
  } else if (type == "drugs") {
    df_out <- vars_drugs
  } else if (type == "prevention") {
    df_out <- vars_prevention
  } else if (type == "lack") {
    df_out <- vars_lack_medical
  } else if (type == "physical") {
    df_out <- vars_physical_activity
  } else if (type == "physical_activity") {
    df_out <- vars_physical_activity
  } else if (type == "nutrition") {
    df_out <- vars_nutrition
  } else if (type == "dental") {
    df_out <- vars_dental
  } else if (type == "smoking") {
    df_out <- vars_smoking
  } else if (type == "alcohol") {
    df_out <- vars_alcohol
  } else if (type == "support") {
    df_out <- vars_support
  } else if (type == "care") {
    df_out <- vars_care
  } else if (type == "other") {
    df_out <- vars_other
  } else {stop("Correct variable type?")}



 df_final = df_out

  return(df_final)

}
