test_that("transect_glance works", {

  expect_error(transect_glance("hi"))

  test_custom <- download_transect(7025) # 7025 is custom
  expect_error(transect_glance(test_custom))

  test_ok <- download_transect(4492) |> transect_glance()

  expect_equal(ncol(test_ok), 53)
  expect_equal(nrow(test_ok), 1)
  expect_equal(typeof(test_ok$`Total Mean C`), "double")
})
