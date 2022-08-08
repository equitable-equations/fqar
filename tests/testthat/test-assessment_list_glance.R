test_that("assessment_list_glance works", {
  test_vec <- c(25961, 25640)
  test_list <- download_assessment_list(63, id %in% test_vec)
  output_df <- assessment_list_glance(test_list)

  expect_equal(ncol(output_df), 50)
  expect_equal(typeof(output_df$`Total Mean C`), "double")
  expect_gt(nrow(output_df), 1)
})
