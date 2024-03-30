test_that("download_database works", {

  expect_error(download_database("hi"), "database_id must be an integer.")
  expect_error(download_database(2.5), "database_id must be an integer.")

  null_output <- download_database(-40000)
  expect_equal(nrow(null_output), 0)
  expect_equal(memoise::has_cache(download_database_internal)(-40000), FALSE)

  skip_if_offline()

  expect_message(download_database(3))

  test_db <- suppressMessages(download_database(1))
  if (nrow(test_db != 0)){
    expect_equal(test_db$V1[1], "Chicago Region")
    expect_equal(ncol(test_db), 9)
    expect_equal(class(test_db), c("tbl_df",
                                   "tbl",
                                   "data.frame"))
  } else {
    expect_message(download_database(1))
  }

})
