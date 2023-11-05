test_that("is_inventory works", {

  expect_true(is_inventory(test_inventory))
  expect_false(is_inventory("hi"))
  expect_false(is_inventory(faithful))
  expect_false(is_inventory(NULL))
  expect_false(is_inventory(test_assessment))

  skip_on_cran()

  edison <- download_assessment(25002)
  expect_true(is_inventory(assessment_inventory(edison)))

})
