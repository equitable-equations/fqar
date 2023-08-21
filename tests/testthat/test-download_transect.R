test_that("download_transect works", {

  expect_error(download_transect("hi"), "transect_id must be an integer.")
  expect_error(download_transect(2.5), "transect_id must be an integer.")

  null_output <- download_transect(-40000)
  expect_null(null_output)
  expect_equal(memoise::has_cache(download_transect_internal)(-40000), FALSE)

  skip_on_cran()

  expect_equal(ncol(download_transect(6322)), 14)
})

