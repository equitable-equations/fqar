test_that("download_assessment_list works", {

  expect_equal(class(suppressMessages(download_assessment_list(-2))), "list")

  skip_if_offline()

  two_assessments <- suppressMessages(download_assessment_list(1,
                                                               id == 8 | id == 12))

  if(length(two_assessments) != 0) {
    expect_message(download_assessment_list(1, id == "hi"), "No matches found. Empty list returned.")
    expect_equal(class(two_assessments), "list")
    expect_equal(length(two_assessments), 2)
    expect_equal(class(two_assessments[[1]]), c("tbl_df",
                                                "tbl",
                                                "data.frame"))
  expect_equal(ncol(two_assessments[[1]]), 9)
  } else {
    # if server doesn't respond
    expect_message(download_assessment_list(1))
  }
})
