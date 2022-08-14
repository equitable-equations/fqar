test_that("index_fqa_databases works", {

  expect_error(index_fqa_databases("hi"))

  skip_on_cran()

  databases <- index_fqa_databases()
  expect_equal(ncol(databases), 4)
  expect_equal(names(databases),
               c("database_id", "region", "year", "description"))
  expect_equal(class(databases[[1]]), "numeric")
  expect_equal(class(databases[[4]]), "character")
})



test_that("index_fqa_assessments works", {

  expect_error(index_fqa_assessments(1.5))
  expect_error(index_fqa_assessments("hi"))

  skip_on_cran()

  assessments <- index_fqa_assessments(1)

  expect_equal(ncol(assessments), 5)
  expect_equal(names(assessments),
               c("id", "assessment", "date", "site", "practitioner"))
  expect_equal(class(assessments[[1]]), "numeric")
  expect_equal(class(assessments[[3]]), "Date")
  expect_equal(class(assessments[[5]]), "character")
})



test_that("index_fqa_transects works", {

  expect_error(index_fqa_transects(1.5))
  expect_error(index_fqa_transects("hi"))

  skip_on_cran()

  transects <- index_fqa_transects(1)

  expect_equal(ncol(transects), 5)
  expect_equal(names(transects),
               c("id", "assessment", "date", "site", "practitioner"))
  expect_equal(class(transects[[1]]), "numeric")
  expect_equal(class(transects[[3]]), "Date")
  expect_equal(class(transects[[5]]), "character")
})
