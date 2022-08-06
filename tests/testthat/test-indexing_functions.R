test_that("download_fqa_databases works", {
  expect_equal(ncol(download_fqa_databases()), 4)
  expect_error(download_fqa_databases("hi"))
})


test_that("download_fqa_assessments works",{
  expect_equal(ncol(download_fqa_assessments(1)), 5)
  expect_error(download_fqa_assessments(1.5))
  expect_error(download_fqa_assessments("hi"))
})


test_that("download_fqa_transects works",{
  expect_equal(ncol(download_fqa_transects(1)), 5)
  expect_error(download_fqa_transects(1.5))
  expect_error(download_fqa_transects("hi"))
})
