test_that("download_assessment_internal works", {

  expect_error(download_assessment_internal("hi"), "assessment_id must be an integer.")
  expect_error(download_assessment_internal(2.5), "assessment_id must be an integer.")

  null_output <- download_assessment(-40000)
  expect_null(null_output)
  expect_equal(memoise::has_cache(download_assessment_internal)(-40000), FALSE)

  skip_on_cran()

  expect_error(download_assessment_internal(25003), "The requested assessment is not public")

})
