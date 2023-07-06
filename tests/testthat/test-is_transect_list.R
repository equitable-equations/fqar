test_that("is_transect_list works",  {
  test_raw <- download_transect(4492)
  test_transect_list <- list(test_raw, test_raw)
  test_inv_list <- transect_list_inventory(test_transect_list)
  bad_list <- list(faithful, faithful)

  expect_error(random_unassigned_variable_5000)
  expect_equal(is_transect_list(test_transect_list), TRUE)
  expect_equal(is_transect_list(list(test_raw)), TRUE)
  expect_equal(is_transect_list(test_raw), FALSE)
  expect_equal(is_transect_list(faithful), FALSE)
  expect_equal(is_transect_list(data.frame()), FALSE)
  expect_equal(is_transect_list(bad_list), FALSE)

})
