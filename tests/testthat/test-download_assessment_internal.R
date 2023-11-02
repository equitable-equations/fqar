test_that("download_assessment_internal works", {

  expect_error(download_assessment_internal("hi"), "assessment_id must be an integer.")
  expect_error(download_assessment_internal(2.5), "assessment_id must be an integer.")

  null_output <- download_assessment_internal(-40000)
  expect_equal(nrow(null_output), 0)
  expect_equal(memoise::has_cache(download_assessment_internal)(-40000), TRUE)

  skip_on_cran()

  expect_equal(nrow(suppressMessages(download_assessment_internal(25002))), 140)
})
