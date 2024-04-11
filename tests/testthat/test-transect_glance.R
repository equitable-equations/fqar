test_that("transect_glance works", {

  expect_message(transect_glance("hi"))

  bad <- suppressMessages(transect_glance("hi"))
  expect_equal(nrow(bad), 0)
  expect_equal(ncol(bad), 54)

  test_manual <- transect_glance(test_transect) # manual download
  expect_equal(ncol(test_manual), 54)
  expect_equal(names(test_manual)[9], "fqa_db_region")
  expect_equal(names(test_manual)[13], "custom_fqa_db_name")
  expect_equal(typeof(test_manual$total_mean_c), "double")
  expect_equal(test_manual[[25]], "Transect")

  trans_normal <- suppressMessages(download_transect(4492))
  if (nrow(trans_normal) != 0) {
    test_normal <-  trans_normal |>
      transect_glance() # normal database
    expect_equal(ncol(test_normal), 54)
    expect_equal(nrow(test_normal), 1)
    expect_equal(names(test_normal)[9], "fqa_db_region")
    expect_equal(names(test_normal)[13], "custom_fqa_db_name")
    expect_equal(typeof(test_normal$total_mean_c), "double")
  }

  trans_custom <- suppressMessages(download_transect(7025))
  if (nrow(trans_custom) != 0) {
    test_custom <- trans_custom |>
      transect_glance()  # custom database
    expect_equal(ncol(test_custom), 54)
    expect_equal(nrow(test_custom), 1)
    expect_equal(names(test_custom)[9], "fqa_db_region")
    expect_equal(names(test_custom)[13], "custom_fqa_db_name")
    expect_equal(typeof(test_custom$total_mean_c), "double")
  }

  trans_omernik <- suppressMessages(download_transect(6444))
  if (nrow(trans_omernik) != 0) {
   test_omernik <- trans_omernik |>
      transect_glance()  # includes omernik classification
   expect_equal(ncol(test_omernik), 54)
   expect_equal(nrow(test_omernik), 1)
   expect_equal(names(test_omernik)[9], "fqa_db_region")
   expect_equal(names(test_omernik)[13], "custom_fqa_db_name")
   expect_equal(typeof(test_omernik$total_mean_c), "double")
  }

})
