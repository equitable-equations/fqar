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
