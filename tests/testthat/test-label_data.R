test_that("label_data labels selected variables only", {
  data(adults_19)
  data(adults_19_labels)

  var <- adults_19_labels$variable_ine[1]

  res <- label_data(adults_19, adults_19_labels, vars = var)

  expect_s3_class(res, "data.frame")
  expect_true(var %in% names(res))

  unchanged_vars <- setdiff(names(adults_19), var)

  unchanged <- vapply(
    unchanged_vars,
    function(x) identical(adults_19[[x]], res[[x]]),
    logical(1)
  )

  expect_true(all(unchanged))
})

test_that("label_data preserves unmatched values", {
  df <- data.frame(x = c(1, 2, 999))

  labels <- data.frame(
    variable_ine = c("x", "x"),
    valores_ine = c(1, 2),
    valores = c("Uno", "Dos")
  )

  res <- label_data(df, labels, vars = "x")

  expect_equal(res$x[1], "Uno")
  expect_equal(res$x[2], "Dos")
  expect_equal(res$x[3], "999")
})