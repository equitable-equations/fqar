test_that("assessment_list_glance works", {

  expect_message(assessment_list_glance("hi"))
  expect_message(assessment_list_glance(faithful))
  expect_equal(nrow(suppressMessages(assessment_list_glance("hi"))), 0)
  expect_equal(ncol(suppressMessages(assessment_list_glance("hi"))), 53)

  test_list <- list(test_assessment, test_assessment)
  test_df <- assessment_list_glance(test_list)

  expect_equal(ncol(test_df), 53)
  expect_equal(typeof(test_df$total_mean_c), "double")
  expect_gt(nrow(test_df), 1)

  test_vec <- c(25961, 25640)
  test_list <- suppressMessages(download_assessment_list(63, id %in% test_vec))
  test_df <- suppressMessages(assessment_list_glance(test_list))

  expect_equal(ncol(test_df), 53)

  if (length(test_list) != 0){
    # when server responds
    expect_lt(nrow(test_df)-1, length(test_list))
    expect_equal(typeof(test_df$total_mean_c), "double")
  }
})
