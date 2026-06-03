#' Filter survey data by variable type
#'
#' Returns a subset of columns from a survey dataset that belong to a given
#' thematic category, as defined in the accompanying \code{*_info} dataset.
#' Identifier columns (\code{CCAA} and \code{IDENTHOGAR}) are always included
#' when present.
#'
#' @param df A data frame. One of the main survey datasets
#'   (\code{adults_19}, \code{children_19}, \code{household_19}, etc.).
#' @param info A data frame. The corresponding \code{*_info} dataset
#'   (\code{adults_19_info}, \code{children_19_info}, etc.). Must contain
#'   columns \code{variable_ine} and \code{tipo_variable}.
#' @param type Character string. The variable category to select.
#'   Use \code{unique(info$tipo_variable)} to list available types.
#'
#' @return A data frame with identifier columns plus all variables belonging
#'   to \code{type}.
#'
#' @examples
#' # See available types
#' unique(adults_19_info$tipo_variable)
#'
#' # Filter to health status variables
#' get_variable(adults_19, adults_19_info, "G. ESTADO DE SALUD")
#'
#' @export
get_variable <- function(df, info, type) {
  if (!type %in% info$tipo_variable) {
    stop("'", type, "' not found in info$tipo_variable. ",
         "Use unique(info$tipo_variable) to see available types.")
  }
  vars <- info$variable_ine[info$tipo_variable == type]
  id_cols <- intersect(c("CCAA", "IDENTHOGAR"), names(df))
  cols <- unique(c(id_cols, vars))
  df[, cols[cols %in% names(df)], drop = FALSE]
}
