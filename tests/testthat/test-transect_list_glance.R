test_that("transect_list_glance works", {

  expect_error(transect_list_glance("hi"))

  test_vec <- c(6875, 6736)
  test_list <- download_transect_list(63, id %in% test_vec)
  test <- transect_list_glance(test_list)

  expect_equal(ncol(test), 55)
  expect_equal(typeof(test$`Total Mean C`), "double")
  expect_equal(nrow(test), 2)
})
