test_that("index_fqa_transects_internal works", {

  expect_error(index_fqa_transects_internal(1.5))
  expect_error(index_fqa_transects_internal("hi"))

  empty_output <- index_fqa_transects_internal(-40000)
  expect_equal(nrow(empty_output), 0)
  expect_equal(ncol(empty_output), 5)
  expect_true(memoise::has_cache(index_fqa_transects_internal)(-40000))

  skip_on_cran()

  transects <- index_fqa_transects_internal(1)

  expect_equal(ncol(transects), 5)
  expect_equal(names(transects),
               c("id", "assessment", "date", "site", "practitioner"))
  expect_equal(class(transects), c("tbl_df",
                                   "tbl",
                                   "data.frame"))
  expect_equal(class(transects[[1]]), "numeric")
  expect_equal(class(transects[[3]]), "Date")
  expect_equal(class(transects[[5]]), "character")

})
