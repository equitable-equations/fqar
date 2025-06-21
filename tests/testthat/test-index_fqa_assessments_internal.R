test_that("index_fqa_assessments_internal works", {

  expect_error(index_fqa_assessments_internal(1.5))
  expect_error(index_fqa_assessments_internal("hi"))
  expect_error(index_fqa_assessments_internal(2, "hi"),
               "timeout must be an integer.")

  empty_output <- index_fqa_assessments_internal(-40000)
  expect_equal(nrow(empty_output), 0)
  expect_equal(ncol(empty_output), 5)
  expect_equal(memoise::has_cache(index_fqa_assessments_internal)(-40000), TRUE)

  assessments <- suppressMessages(
    index_fqa_assessments_internal(2, timeout = 10))

  expect_equal(ncol(assessments), 5)
  expect_equal(names(assessments),
               c("id", "assessment", "date", "site", "practitioner"))
  expect_equal(class(assessments), c("tbl_df",
                                     "tbl",
                                     "data.frame"))
  expect_equal(class(assessments[[1]]), "numeric")
  expect_equal(class(assessments[[3]]), "Date")
  expect_equal(class(assessments[[5]]), "character")

})
