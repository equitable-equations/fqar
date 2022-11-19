test_that("assessment_inventory works", {

  expect_error(assessment_inventory("hi"))

  test_man <- assessment_inventory(test_assessment_manual)
  expect_equal(ncol(test_man), 9)
  expect_equal(names(test_man)[5], "c")
  expect_equal(typeof(test_man$c), "double")
  expect_equal(test_man$c[1], 0)

  skip_on_cran()

  test_raw <- download_assessment(25002)
  test_auto <- assessment_inventory(test_raw)
  expect_equal(ncol(test_auto), 9)
  expect_equal(names(test_auto)[5], "c")
  expect_equal(typeof(test_auto$c), "double")

})
