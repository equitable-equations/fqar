test_that("is_transect works", {

  expect_true(is_transect(test_transect))
  expect_false(is_transect(random_unassigned_variables_40000))

  expect_false(is_transect(faithful))
  expect_false(is_transect("hi"))
  expect_false(is_transect(data.frame()))

  test_raw <- download_transect(4492)
  expect_true(is_transect(test_raw))

})
