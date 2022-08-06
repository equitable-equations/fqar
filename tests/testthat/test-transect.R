test_that("transect_glance works", {
  test <- download_transect(6875)
  test <- transect_glance(test)

  expect_equal(ncol(test), 53)
  expect_equal(nrow(test), 1)
  expect_equal(typeof(test$`Total Mean C`), "double")
})

test_that("transect_inventory works", {
  test <- download_transect(25002)
  test <- transect_inventory(test)

  expect_equal(ncol(test), 13)
  expect_equal(typeof(test$C), "double")
})

test_that("transect_phys works", {
  test <- download_transect(25002)
  test <- transect_phys(test)

  expect_equal(ncol(test), 6)
  expect_equal(typeof(test$Frequency), "double")
})

test_that("transect_list_glance works", {
  test_vec <- c(6875, 6736)
  test <- download_transect_list(63, id %in% test_vec)
  test <- transect_list_glance(test)

  expect_equal(ncol(test), 53)
  expect_equal(typeof(test$`Total Mean C`), "double")
  expect_gt(nrow(test), 1)
})
