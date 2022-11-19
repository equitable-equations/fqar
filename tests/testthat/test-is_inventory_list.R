test_that("is_inventory_list works", {
  test_list <- list(test_assessment, test_assessment)
  test_inv_list <- assessment_list_inventory(test_list)
  bad_list <- list(faithful, faithful)

  expect_error(random_unassigned_variable_5000)
  expect_equal(is_inventory_list(test_inv_list), TRUE)
  expect_equal(is_inventory_list(test_assessment), FALSE)
  expect_equal(is_inventory_list(faithful), FALSE)
  expect_equal(is_inventory_list(data.frame()), FALSE)
  expect_equal(is_inventory_list(bad_list), FALSE)

})
