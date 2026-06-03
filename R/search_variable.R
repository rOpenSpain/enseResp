#' Search variables by description
#'
#' @param info A variable metadata data frame.
#' @param pattern Text pattern to search for.
#'
#' @return A data frame with matching rows.
#' @export
search_variable <- function(info, pattern) {
  if (!is.data.frame(info)) {
    stop("info must be a data frame.", call. = FALSE)
  }

  if (missing(pattern) || length(pattern) != 1 || !is.character(pattern) || is.na(pattern)) {
    stop("pattern must be a single non-missing character string.", call. = FALSE)
  }

  if (!"descripcion_del_campo" %in% names(info)) {
    stop("info must contain column `descripcion_del_campo`.", call. = FALSE)
  }

  info[
    grepl(pattern, info[["descripcion_del_campo"]], ignore.case = TRUE),
    ,
    drop = FALSE
  ]
}