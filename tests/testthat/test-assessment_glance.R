test_that("assessment_glance works", {

  expect_error(assessment_glance("hi"))

  test <- download_assessment(25002)
  test <- assessment_glance(test)

  expect_equal(ncol(test), 52)
  expect_equal(nrow(test), 1)
  expect_equal(typeof(test$`Total Mean C`), "double")
})
