test_that("get_variable returns selected variables", {
  data(adults_19)
  data(adults_19_info)

  tipo <- unique(adults_19_info$tipo_variable)[1]

  res <- get_variable(adults_19, adults_19_info, tipo)

  expect_s3_class(res, "data.frame")
  expect_equal(nrow(res), nrow(adults_19))
  expect_true(all(names(res) %in% names(adults_19)))

  vars_tipo <- adults_19_info$variable_ine[
    adults_19_info$tipo_variable == tipo
  ]

  id_cols <- intersect(c("CCAA", "IDENTHOGAR"), names(adults_19))

  expect_true(all(setdiff(names(res), id_cols) %in% vars_tipo))
})

test_that("get_variable errors for unavailable type", {
  data(adults_19)
  data(adults_19_info)

  expect_error(
    get_variable(adults_19, adults_19_info, "tipo_inexistente")
  )
})