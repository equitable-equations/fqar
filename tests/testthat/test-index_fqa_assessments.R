test_that("index_fqa_assessments works", {

  expect_error(index_fqa_assessments(1.5))
  expect_error(index_fqa_assessments("hi"))

  skip_on_cran()

  assessments <- index_fqa_assessments(2)

  expect_equal(ncol(assessments), 5)
  expect_equal(names(assessments),
               c("id", "assessment", "date", "site", "practitioner"))
  expect_equal(class(assessments[[1]]), "numeric")
  expect_equal(class(assessments[[3]]), "Date")
  expect_equal(class(assessments[[5]]), "character")
})
