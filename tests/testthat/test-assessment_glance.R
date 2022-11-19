test_that("assessment_glance works", {

  expect_error(assessment_glance("hi"))
  expect_error(assessment_glance(faithful))

  test_man <- assessment_glance(test_assessment_manual)
  expect_equal(ncol(test_man), 52)
  expect_equal(nrow(test_man), 1)
  expect_equal(names(test_man)[8], "fqa_db_region")
  expect_equal(names(test_man)[42], "grass")
  expect_equal(typeof(test_man$total_mean_c), "double")

  skip_on_cran()

  test_auto <- download_assessment(25002)
  test <- assessment_glance(test_auto)

  expect_equal(ncol(test), 52)
  expect_equal(nrow(test), 1)
  expect_equal(names(test)[8], "fqa_db_region")
  expect_equal(names(test)[42], "grass")
  expect_equal(typeof(test$total_mean_c), "double")
})
