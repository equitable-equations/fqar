test_that("download_assessment_list works", {

  skip_on_cran()

  expect_null(suppressMessages(download_assessment_list(-2)))

  expect_warning(download_assessment_list(1, id == "hi"), "No matches found. Empty list returned.")
  two_assessments <- download_assessment_list(1, id == 8 | id == 12)
  expect_equal(class(two_assessments), "list")
  expect_equal(length(two_assessments), 2)
  expect_equal(class(two_assessments[[1]]), "data.frame")
  expect_equal(ncol(two_assessments[[1]]), 9)
})


