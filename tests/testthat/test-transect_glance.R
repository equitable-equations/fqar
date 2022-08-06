test_that("transect_glance works", {

  expect_error(transect_glance("hi"))

  test <- download_transect(6875)
  test <- transect_glance(test)

  expect_equal(ncol(test), 53)
  expect_equal(nrow(test), 1)
  expect_equal(typeof(test$`Total Mean C`), "double")
})
