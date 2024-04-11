test_that("download_transect_list works", {

  expect_equal(length(suppressMessages(download_transect_list(-2))), 0)

  expect_message(download_transect_list(1, id == "hi"))

  two_transects <- suppressMessages(download_transect_list(1, id == 6570 | id == 6322))

  if (length(two_transects) !=0){
    expect_equal(class(two_transects), "list")
    expect_equal(length(two_transects), 2)
    expect_equal(class(two_transects[[1]]), c("tbl_df",
                                              "tbl",
                                              "data.frame"))
    expect_equal(ncol(two_transects[[1]]), 14)
  }
})



