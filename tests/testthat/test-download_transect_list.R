test_that("download_transect_list works", {

  skip_on_cran()

  expect_error(download_transect_list(-2))

  expect_warning(download_transect_list(1, id == "hi"), "No matches found. Empty list returned.")
  two_transects <- download_transect_list(1, id == 6570 | id == 6322)
  expect_equal(class(two_transects), "list")
  expect_equal(length(two_transects), 2)
  expect_equal(class(two_transects[[1]]), "data.frame")
  expect_equal(ncol(two_transects[[1]]), 14)
})



