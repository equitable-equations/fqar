test_that("index_fqa_transects_internal works", {

  expect_error(index_fqa_transects_internal(1.5))
  expect_error(index_fqa_transects_internal("hi"))

  null_output <- index_fqa_transects(-40000)
  expect_null(null_output)
  expect_equal(memoise::has_cache(index_fqa_transects_internal)(-40000), FALSE)

  skip_on_cran()

  transects <- index_fqa_transects_internal(1)

  expect_equal(ncol(transects), 5)
  expect_equal(names(transects),
               c("id", "assessment", "date", "site", "practitioner"))
  expect_equal(class(transects[[1]]), "numeric")
  expect_equal(class(transects[[3]]), "Date")
  expect_equal(class(transects[[5]]), "character")

})
