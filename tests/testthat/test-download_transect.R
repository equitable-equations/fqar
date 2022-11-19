test_that("download_transect works", {

  expect_error(download_transect("hi"), "transect_id must be an integer.")
  expect_error(download_transect(2.5), "transect_id must be an integer.")

  skip_on_cran()

  expect_equal(ncol(download_transect(6322)), 14)
})

