test_that("is_assessment_list works", {

  test_list <- list(test_assessment, test_assessment)

  expect_error(random_unassigned_variable_5000)
  expect_equal(is_assessment_list(test_list), TRUE)
  expect_equal(is_assessment_list(list(test_assessment)), TRUE)
  expect_equal(is_assessment_list(test_assessment), FALSE)
  expect_equal(is_assessment_list(faithful), FALSE)
  expect_equal(is_assessment_list(data.frame()), FALSE)
  expect_equal(is_assessment_list(list(faithful, faithful)), FALSE)

})
