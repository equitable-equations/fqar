test_that("download_database_internal works", {

  expect_error(download_database_internal("hi"),
               "database_id must be an integer.")
  expect_error(download_database_internal(2.5),
               "database_id must be an integer.")
  expect_error(download_database_internal(1, "hi"),
               "timeout must be an integer.")

  null_output <- download_database_internal(-40000)
  expect_equal(nrow(null_output), 0)
  expect_equal(memoise::has_cache(download_database_internal)(-40000), TRUE)

  test_db <- suppressMessages(download_database_internal(1))

  if (nrow(test_db) != 0) {
    # when server responds
    expect_equal(ncol(test_db), 9)
    expect_equal(test_db$V1[1], "Chicago Region")
    expect_equal(class(test_db), c("tbl_df",
                                   "tbl",
                                   "data.frame"))
  }
})
