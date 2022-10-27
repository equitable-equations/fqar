test_that("download_database works", {

  expect_error(download_database("hi"), "database_id must be an integer.")
  expect_error(download_database(2.5), "database_id must be an integer.")

  skip_on_cran()

  test_db <- download_database(1)
  expect_equal(test_db[1, 1], "Chicago Region")
  expect_equal(ncol(test_db), 9)
})
