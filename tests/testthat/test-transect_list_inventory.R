test_that("transect_list_inventory works",  {

  test_transect <- list(test_transect,
                        test_transect2,
                        test_transect_manual)
  inv_list <- transect_list_inventory(test_transect)

  expect_equal(class(inv_list), "list")
  expect_equal(length(inv_list), 3)
  expect_equal(ncol(inv_list[[1]]), 14)

  bad_list <- list(faithful)

  expect_error(transect_list_inventory(bad_list))
  expect_error(transect_list_inventory(faithful))
  expect_error(transect_list_inventory(17))
  expect_error(transect_list_inventory(NULL))
})
