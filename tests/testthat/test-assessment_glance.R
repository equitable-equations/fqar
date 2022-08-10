test_that("assessment_glance works", {

  expect_error(assessment_glance("hi"))
  expect_error(assessment_glance(faithful))

  test_auto <- download_assessment(25002)
  test <- assessment_glance(test_auto)

  expect_equal(ncol(test), 52)
  expect_equal(nrow(test), 1)
  expect_equal(names(test)[8], "FQA DB Region")
  expect_equal(names(test)[42], "Grass")
  expect_equal(typeof(test$`Total Mean C`), "double")

  test2 <- assessment_glance(test_assessment)
  expect_equal(ncol(test2), 52)
  expect_equal(nrow(test2), 1)
  expect_equal(names(test2)[8], "FQA DB Region")
  expect_equal(names(test2)[42], "Grass")
  expect_equal(typeof(test2$`Total Mean C`), "double")
})
