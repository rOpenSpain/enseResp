#' Replace coded values with labels
#'
#' @param df A data frame.
#' @param labels A labels data frame with columns `valores_ine`, `valores`, and `variable_ine`.
#' @param vars Optional character vector of variables to label.
#'
#' @return A data frame with selected variables labelled.
#' @export
label_data <- function(df, labels, vars = NULL) {
  required_cols <- c("valores_ine", "valores", "variable_ine")

  missing_cols <- setdiff(required_cols, names(labels))
  if (length(missing_cols) > 0) {
    stop(
      "labels must contain columns: ",
      paste(required_cols, collapse = ", "),
      call. = FALSE
    )
  }

  if (!is.data.frame(df)) {
    stop("df must be a data frame.", call. = FALSE)
  }

  if (is.null(vars)) {
    target_vars <- unique(labels$variable_ine)
  } else {
    if (!is.character(vars)) {
      stop("vars must be NULL or a character vector.", call. = FALSE)
    }
    target_vars <- vars
  }

  target_vars <- intersect(target_vars, names(df))

  for (var in target_vars) {
    lookup <- labels[labels$variable_ine == var, ]

    matched <- match(as.character(df[[var]]), as.character(lookup$valores_ine))
    labelled_values <- as.character(lookup$valores[matched])

    original_values <- as.character(df[[var]])
    df[[var]] <- ifelse(is.na(labelled_values), original_values, labelled_values)
  }

  df
}