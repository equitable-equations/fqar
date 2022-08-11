test_that("transect_glance works", {

  expect_error(transect_glance("hi"))

  test_normal <- download_transect(4492) |>
    transect_glance()  # 4492 is ordinary
  expect_equal(ncol(test_normal), 54)
  expect_equal(nrow(test_normal), 1)
  expect_equal(names(test_normal)[9], "FQA DB Region")
  expect_equal(names(test_normal)[13], "Custom FQA DB Name")
  expect_equal(typeof(test_normal$`Total Mean C`), "double")

  test_custom <- download_transect(7025) |>
    transect_glance()  # 7025 is custom
  expect_equal(ncol(test_custom), 54)
  expect_equal(nrow(test_custom), 1)
  expect_equal(names(test_custom)[9], "FQA DB Region")
  expect_equal(names(test_custom)[13], "Custom FQA DB Name")
  expect_equal(typeof(test_custom$`Total Mean C`), "double")

  test_omernik <- download_transect(6444) |>
    transect_glance()  # 6444 includes an omernik classification
  expect_equal(ncol(test_omernik), 54)
  expect_equal(nrow(test_omernik), 1)
  expect_equal(names(test_omernik)[9], "FQA DB Region")
  expect_equal(names(test_omernik)[13], "Custom FQA DB Name")
  expect_equal(typeof(test_omernik$`Total Mean C`), "double")

  test_manual <- transect_glance(test_transect)
  expect_equal(ncol(test_manual), 54)
  expect_equal(names(test_manual)[9], "FQA DB Region")
  expect_equal(names(test_manual)[13], "Custom FQA DB Name")
  expect_equal(typeof(test_manual$`Total Mean C`), "double")
  expect_equal(test_manual[[25]], "Transect")
})
