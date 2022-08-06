test_that("assessment_inventory works", {

  expect_error(assessment_inventory("hi"))

  test <- download_assessment(25002)
  test <- assessment_inventory(test)

  expect_equal(ncol(test), 9)
  expect_equal(typeof(test$C), "double")
})
