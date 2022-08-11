test_that("transect_inventory works", {

  expect_error(transect_inventory("hi"))
  expect_error(trasect_inventory(faithful))

  test_raw <- download_transect(4492) # normal
  test <- transect_inventory(test_raw)
  expect_equal(ncol(test), 13)
  expect_equal(names(test)[5], "C")
  expect_equal(typeof(test[[5]]), "double")

  test_raw <- download_transect(7025) # custom
  test <- transect_inventory(test_raw)
  expect_equal(ncol(test), 13)
  expect_equal(names(test)[5], "C")
  expect_equal(typeof(test[[5]]), "double")

  test_raw <- download_transect(6444) # included omernik
  test <- transect_inventory(test_raw)
  expect_equal(ncol(test), 13)
  expect_equal(names(test)[5], "C")
  expect_equal(typeof(test[[5]]), "double")

  test_manual <- transect_inventory(test_transect)
  expect_equal(ncol(test_manual), 13)
  expect_equal(names(test_manual)[5], "C")
  expect_equal(typeof(test_manual[[5]]), "double")
  expect_equal(test_manual[[5]], 0)
})
