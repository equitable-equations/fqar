test_that("download_transect_internal works", {

  expect_error(download_transect_internal("hi"), "transect_id must be an integer.")
  expect_error(download_transect_internal(2.5), "transect_id must be an integer.")

  null_output <- download_transect_internal(-40000)
  expect_equal(nrow(null_output), 0)
  expect_true(memoise::has_cache(download_transect_internal)(-40000))

  skip_on_cran()

  test_tr <- download_transect_internal(6322)
  expect_equal(ncol(test_tr), 14)
  expect_equal(class(test_tr), c("tbl_df",
                                 "tbl",
                                 "data.frame"))
})
