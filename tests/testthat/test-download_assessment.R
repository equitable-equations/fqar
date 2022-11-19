test_that("download_assessment works", {

  expect_error(download_assessment("hi"), "assessment_id must be an integer.")
  expect_error(download_assessment(2.5), "assessment_id must be an integer.")

  skip_on_cran()

  expect_error(download_assessment(25003), "The requested assessment is not public")
  expect_equal(ncol(download_assessment(25002)), 9)
})

