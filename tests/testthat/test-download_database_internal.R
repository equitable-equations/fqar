test_that("download_database_internal works", {

  expect_error(download_database("hi"), "database_id must be an integer.")
  expect_error(download_database(2.5), "database_id must be an integer.")

  null_output <- download_database(-40000)
  expect_null(null_output)
  expect_equal(memoise::has_cache(download_database_internal)(-40000), FALSE)

  skip_on_cran()

  test_db <- download_database(1)
  expect_equal(test_db[1, 1], "Chicago Region")
  expect_equal(ncol(test_db), 9)

  expect_warning(download_database(3))
})
