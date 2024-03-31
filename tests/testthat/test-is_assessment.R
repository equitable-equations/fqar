test_that("is_assessment works", {

  expect_true(is_assessment(test_assessment))

  expect_false(is_assessment(faithful))
  expect_false(is_assessment("hi"))
  expect_false(is_assessment(data.frame()))

  test_raw <- suppressMessages(download_assessment(25002))

  if (nrow(test_raw) != 0) {
    expect_true(is_assessment(test_raw))
  } else {
    # for when server doesn't respond
    expect_false(is_assessment(test_raw))
  }
})
