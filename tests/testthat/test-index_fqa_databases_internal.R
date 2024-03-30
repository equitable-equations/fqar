test_that("index_fqa_databases_internal works", {

  expect_error(index_fqa_databases_internal("hi"))

  skip_if_offline()

  databases <- suppressMessages(index_fqa_databases_internal())

  expect_equal(ncol(databases), 4)
  expect_equal(names(databases), c("database_id", "region", "year", "description"))
  expect_equal(class(databases), c("tbl_df",
                                   "tbl",
                                   "data.frame"))
  expect_equal(class(databases[[1]]), "numeric")
  expect_equal(class(databases[[4]]), "character")

})
