test_that("database_inventory works", {

  expect_error(database_inventory("hi"))

  test_man <- database_inventory(test_database)
  expect_equal(ncol(test_man), 9)
  expect_equal(names(test_man)[5], "C")
  expect_equal(typeof(test_man$C), "double")

  skip_on_cran()

  test_raw <- download_assessment(25002)
  test_auto <- assessment_inventory(test_raw)
  expect_equal(ncol(test_auto), 9)
  expect_equal(names(test_auto)[5], "C")
  expect_equal(typeof(test_auto$C), "double")

})
