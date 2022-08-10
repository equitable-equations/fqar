test_that("assessment_inventory works", {

  expect_error(assessment_inventory("hi"))

  test_raw <- download_assessment(25002)
  test <- assessment_inventory(test_raw)

  expect_equal(ncol(test), 9)
  expect_equal(typeof(test$C), "double")
})
