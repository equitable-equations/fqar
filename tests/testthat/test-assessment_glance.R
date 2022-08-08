test_that("assessment_glance works", {

  expect_error(assessment_glance("hi"))
  expect_error(assessment_glance(faithful))

  test_raw <- download_assessment(25002)
  test <- assessment_glance(test_raw)

  expect_equal(ncol(test), 52)
  expect_equal(nrow(test), 1)
  expect_equal(names(test)[8], "FQA DB Region")
  expect_equal(names(test)[42], "Grass")
  expect_equal(typeof(test$`Total Mean C`), "double")
})
