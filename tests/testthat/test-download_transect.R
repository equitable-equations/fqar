test_that("download_transect works", {

  expect_error(download_transect("hi"), "transect_id must be an integer.")
  expect_error(download_transect(2.5), "transect_id must be an integer.")

  null_output <- download_transect(-40000)
  expect_equal(nrow(null_output), 0)
  expect_false(memoise::has_cache(download_transect_internal)(-40000))

  skip_if_offline()

  expect_equal(ncol(download_transect(6322)), 14)
})

