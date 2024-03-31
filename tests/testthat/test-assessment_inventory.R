test_that("assessment_inventory works", {

  expect_message(assessment_inventory("hi"))
  em <- suppressMessages(assessment_inventory("hi"))
  expect_true(is.data.frame(em))
  expect_equal(ncol(em), 9)
  expect_equal(nrow(em), 0)

  test_man <- assessment_inventory(test_assessment_manual)
  expect_equal(ncol(test_man), 9)
  expect_equal(names(test_man)[5], "c")
  expect_equal(typeof(test_man$c), "double")
  expect_equal(test_man$c[1], 0)

  test_raw <- suppressMessages(download_assessment(25002))
  test_auto <- suppressMessages(assessment_inventory(test_raw))

  expect_equal(ncol(test_auto), 9)

  if (nrow(test_raw) != 0) {
    expect_equal(names(test_auto)[5], "c")
    expect_equal(typeof(test_auto$c), "double")
  }

})
