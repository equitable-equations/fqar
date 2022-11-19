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
