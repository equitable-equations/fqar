test_that("database_glance works", {

  expect_error(database_glance("hi"))
  expect_error(database_glance(faithful))

  test_man <- database_glance(test_database)
  expect_equal(ncol(test_man), 8)
  expect_equal(nrow(test_man), 1)
  expect_equal(names(test_man)[1], "region")
  expect_equal(names(test_man)[5], "native_species")
  expect_equal(typeof(test_man$total_species), "double")

  skip_on_cran()

  test_auto <- download_database(1)
  test <- database_glance(test_auto)

  expect_equal(ncol(test), 8)
  expect_equal(nrow(test), 1)
  expect_equal(names(test)[1], "region")
  expect_equal(names(test)[5], "native_species")
  expect_equal(typeof(test$total_species), "double")
})
