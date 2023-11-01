test_that("is_assessment works", {

  expect_true(is_assessment(test_assessment))

  expect_false(is_assessment(faithful))
  expect_false(is_assessment("hi"))
  expect_false(is_assessment(data.frame()))

  test_raw <- download_assessment(25002)
  expect_true(is_assessment(test_raw))
})
