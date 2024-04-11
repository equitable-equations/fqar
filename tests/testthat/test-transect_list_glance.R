test_that("transect_list_glance works", {

  expect_message(transect_list_glance("hi"))
  expect_message(transect_list_glance(faithful))

  test_list <- list(test_transect, test_transect)
  test_df <- transect_list_glance(test_list)

  expect_equal(ncol(test_df), 54)
  expect_equal(typeof(test_df$total_mean_c), "double")
  expect_equal(nrow(test_df), 2)

  test_vec <- c(6875, 6736)

  if (length(suppressMessages(download_transect_list(63, id %in% test_vec))) != 0){
    test_list <- download_transect_list(63, id %in% test_vec)
    test_df <- transect_list_glance(test_list)

    expect_equal(ncol(test_df), 54)
    expect_equal(nrow(test_df), length(test_list))
    expect_equal(typeof(test_df$total_mean_c), "double")
    expect_equal(nrow(test_df), 2)
  } else {
    expect_message(download_transect_list(63, id %in% test_vec))
  }
})
