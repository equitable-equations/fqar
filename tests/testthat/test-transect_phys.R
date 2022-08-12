test_that("transect_phys works", {

  expect_error(transect_phys("hi"))
  expect_error(transect_phy(faithful))

  test <- transect_phys(test_transect) # manual download
  expect_equal(ncol(test), 6)
  expect_equal(typeof(test[[2]]), "double")
  expect_equal(names(test)[2], "Frequency")

  skip_on_cran()

  test_raw <- download_transect(4492) # normal database
  test <- transect_phys(test_raw)
  expect_equal(ncol(test), 6)
  expect_equal(typeof(test[[2]]), "double")
  expect_equal(names(test)[2], "Frequency")


  test_raw <- download_transect(7025) # custom database
  test <- transect_phys(test_raw)
  expect_equal(ncol(test), 6)
  expect_equal(typeof(test[[2]]), "double")
  expect_equal(names(test)[2], "Frequency")

  test_raw <- download_transect(6444) # includes omernik
  test <- transect_phys(test_raw)
  expect_equal(ncol(test), 6)
  expect_equal(typeof(test[[2]]), "double")
  expect_equal(names(test)[2], "Frequency")

})
