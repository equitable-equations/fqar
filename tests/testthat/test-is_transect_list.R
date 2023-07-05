test_that("is_transect_list works",  {
  test_list <- list(test_transect, test_transect)

  expect_error(random_unassigned_variable_5000)
  expect_equal(is_transect_list(test_list), TRUE)
  expect_equal(is_transect_list(list(test_transect)), TRUE)
  expect_equal(is_transect_list(test_transect), FALSE)
  expect_equal(is_transect_list(faithful), FALSE)
  expect_equal(is_transect_list(data.frame()), FALSE)
  expect_equal(is_transect_list(list(faithful, faithful)), FALSE)

})
