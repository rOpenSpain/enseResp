test_that("search_variable finds variables by description", {
  data(adults_19)
  data(adults_19_info)

  res <- search_variable(adults_19_info, "edad")

  expect_s3_class(res, "data.frame")
  expect_gt(nrow(res), 0)
})

test_that("search_variable errors if description column is missing", {
  data(adults_19_info)

  bad_info <- adults_19_info
  bad_info$descripcion_del_campo <- NULL

  expect_error(search_variable(bad_info, "edad"))
})