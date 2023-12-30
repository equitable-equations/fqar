test_that("transect_inventory works", {

  expect_message(transect_inventory("hi"))
  expect_message(transect_inventory(faithful))

  blank <- suppressMessages(transect_inventory(faithful))
  expect_equal(nrow(blank), 0)
  expect_equal(ncol(blank), 13)

  test_manual <- transect_inventory(test_transect) #manual download
  expect_equal(ncol(test_manual), 13)
  expect_equal(names(test_manual)[5], "c")
  expect_equal(typeof(test_manual[[5]]), "double")
  expect_equal(test_manual[[5]], 0)

  skip_if_offline()

  test_raw <- download_transect(4492) # normal database
  test <- transect_inventory(test_raw)
  expect_equal(ncol(test), 13)
  expect_equal(names(test)[5], "c")
  expect_equal(typeof(test[[5]]), "double")

  test_raw <- download_transect(7025) # custom databse
  test <- transect_inventory(test_raw)
  expect_equal(ncol(test), 13)
  expect_equal(names(test)[5], "c")
  expect_equal(typeof(test[[5]]), "double")

  test_raw <- download_transect(6444) # included omernik
  test <- transect_inventory(test_raw)
  expect_equal(ncol(test), 13)
  expect_equal(names(test)[5], "c")
  expect_equal(typeof(test[[5]]), "double")

})
