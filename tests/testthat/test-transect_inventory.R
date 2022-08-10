test_that("transect_inventory works", {

  expect_error(transect_inventory("hi"))

  test_raw <- download_transect(25002)
  test <- transect_inventory(test_raw)

  expect_equal(ncol(test), 13)
  expect_equal(typeof(test$C), "double")
})
