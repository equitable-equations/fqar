test_that("transect_phys works", {

  expect_error(transect_phys("hi"))

  test <- download_transect(25002)
  test <- transect_phys(test)

  expect_equal(ncol(test), 6)
  expect_equal(typeof(test$Frequency), "double")
})
