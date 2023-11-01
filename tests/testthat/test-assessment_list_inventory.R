test_that("assessment_list_inventory works", {

  test_assessments <- list(test_assessment,
                           test_assessment2,
                           test_assessment_manual)
  inv_list <- assessment_list_inventory(test_assessments)

  expect_equal(class(inv_list), "list")
  expect_equal(length(inv_list), 3)
  expect_equal(ncol(inv_list[[1]]), 9)

  bad_list <- list(faithful)

  expect_message(assessment_list_inventory(bad_list))
  expect_message(assessment_list_inventory(faithful))
  expect_message(assessment_list_inventory(17))
  expect_message(assessment_list_inventory(NULL))

  expect_equal(ncol(suppressMessages(assessment_list_inventory(bad_list))), 9)
  expect_equal(nrow(suppressMessages(assessment_list_inventory(bad_list))), 0)
})

