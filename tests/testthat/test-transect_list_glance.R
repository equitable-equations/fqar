test_that("transect_list_glance works", {

  expect_error(transect_list_glance("hi"))
  expect_error(transect_list_glance(faithful))

  test_list <- list(test_transect, test_transect)
  test_df <- transect_list_glance(test_list)

  expect_equal(ncol(test_df), 54)
  expect_equal(typeof(test_df$`Total Mean C`), "double")
  expect_equal(nrow(test_df), 2)

  skip_on_cran()

  test_vec <- c(6875, 6736)
  test_list <- download_transect_list(63, id %in% test_vec)
  test_df <- transect_list_glance(test_list)

  expect_equal(ncol(test_df), 54)
  expect_equal(nrow(test_df), length(test_list))
  expect_equal(typeof(test_df$`Total Mean C`), "double")
  expect_equal(nrow(test_df), 2)
})
