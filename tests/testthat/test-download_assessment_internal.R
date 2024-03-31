test_that("download_assessment_internal works", {

  expect_error(download_assessment_internal("hi"), "assessment_id must be an integer.")
  expect_error(download_assessment_internal(2.5), "assessment_id must be an integer.")

  null_output <- download_assessment_internal(-40000)
  expect_equal(nrow(null_output), 0)
  expect_equal(memoise::has_cache(download_assessment_internal)(-40000), TRUE)

  test_a <- suppressMessages(download_assessment_internal(25002))
  expect_equal(class(test_a), c("tbl_df",
                                "tbl",
                                "data.frame"))

  if (nrow(test_a) != 0){
    # when server responds
    expect_equal(nrow(test_a), 140)
    expect_equal(ncol(test_a), 9)
    expect_equal(test_a$V1[1], "Edison dune and swale")
  } else {
    expect_message(download_assessment_internal(25002))
  }

})
