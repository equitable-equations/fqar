test_that("is_transect_list works",  {

  skip_if_offline()

  test_raw <- suppressMessages(download_transect(4492))
  test_transect_list <- list(test_raw, test_raw)
  test_inv_list <- suppressMessages(transect_list_inventory(test_transect_list))
  bad_list <- list(faithful, faithful)

  expect_false(is_transect_list(random_unassigned_variable_5000))
  expect_true(is_transect_list(test_transect_list))
  expect_true(is_transect_list(list(test_raw)))
  expect_false(is_transect_list(test_raw))
  expect_false(is_transect_list(faithful))
  expect_false(is_transect_list(data.frame()))
  expect_false(is_transect_list(bad_list))

  internal_list <- list(test_transect, test_transect)
  expect_true(is_transect_list(test_transect_list))
})
