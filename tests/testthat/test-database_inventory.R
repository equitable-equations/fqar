test_that("database_inventory works", {

  expect_message(database_inventory("hi"))

  bad <- suppressMessages(database_inventory("hi"))
  expect_equal(nrow(bad), 0)
  expect_equal(ncol(bad), 9)

  test_man <- database_inventory(test_database)
  expect_equal(ncol(test_man), 9)
  expect_equal(names(test_man)[5], "c")
  expect_equal(typeof(test_man$c), "double")

  test_raw <- suppressMessages(download_assessment(25002))

  if (nrow(test_raw != 0)) {
    # when server responds
    test_auto <- database_inventory(test_raw)
    expect_equal(ncol(test_auto), 9)
    expect_equal(names(test_auto)[5], "c")
    expect_equal(typeof(test_auto$c), "double")
  } else {
    expect_message(database_inventory(test_raw))
  }
})
