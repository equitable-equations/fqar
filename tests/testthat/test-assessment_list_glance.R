test_that("assessment_list_glance works", {

  expect_error(assessment_list_glance("hi"))
  expect_error(assessment_list_glance(faithful))

  test_list <- list(test_assessment, test_assessment)
  test_df <- assessment_list_glance(test_list)

  expect_equal(ncol(test_df), 52)
  expect_equal(typeof(test_df$`Total Mean C`), "double")
  expect_gt(nrow(test_df), 1)

  skip_on_cran()

  test_vec <- c(25961, 25640)
  test_list <- download_assessment_list(63, id %in% test_vec)
  test_df <- assessment_list_glance(test_list)

  expect_equal(ncol(test_df), 52)
  expect_equal(typeof(test_df$`Total Mean C`), "double")
  expect_gt(nrow(test_df), 1)
})
