test_that("download_assessment works", {

  expect_error(download_assessment("hi"), "assessment_id must be an integer.")
  expect_error(download_assessment(2.5), "assessment_id must be an integer.")

  null_output <- download_assessment(-40000)
  expect_equal(nrow(null_output), 0)
  expect_equal(memoise::has_cache(download_assessment_internal)(-40000), FALSE)

  skip_if_offline()

  test_assessment <- download_assessment(25002)
  expect_equal(ncol(test_assessment), 9)
  expect_equal(memoise::has_cache(download_assessment_internal)(25002), TRUE)
})

