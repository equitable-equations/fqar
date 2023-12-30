test_that("assessment_glance works", {

  expect_message(assessment_glance("hi"))
  expect_message(assessment_glance(faithful))

  test_man <- assessment_glance(test_assessment_manual)
  expect_equal(ncol(test_man), 52)
  expect_equal(nrow(test_man), 1)
  expect_equal(names(test_man)[8], "fqa_db_region")
  expect_equal(names(test_man)[42], "grass")
  expect_equal(typeof(test_man$total_mean_c), "double")

  expect_true(is.data.frame(suppressMessages(assessment_glance(NULL))))
  expect_equal(ncol(suppressMessages(assessment_glance(NULL))), 52)
  expect_equal(nrow(suppressMessages(assessment_glance(NULL))), 0)
  expect_message(assessment_glance(NULL), "data_set is NULL. Empty data frame returned.")

  skip_if_offline()

  test_auto <- suppressMessages(download_assessment(25002))
  test <- suppressMessages(assessment_glance(test_auto))

  expect_equal(ncol(test), 52)
  expect_equal(names(test)[8], "fqa_db_region")
  expect_equal(names(test)[42], "grass")
  expect_equal(typeof(test$total_mean_c), "double")
})
