test_that("transect_list_inventory works",  {

  skip_if_offline()

  test_raw <- download_transect(4492)
  test_transect_list <- list(test_raw,
                             test_raw,
                             test_raw)
  inv_list <- transect_list_inventory(test_transect_list)

  expect_equal(class(inv_list), "list")
  expect_equal(length(inv_list), 3)
  expect_equal(ncol(inv_list[[1]]), 13)

  bad_list <- list(faithful)

  expect_message(transect_list_inventory(bad_list))
  expect_message(transect_list_inventory(faithful))
  expect_true(is.list(suppressMessages(transect_list_inventory(faithful))))

})


