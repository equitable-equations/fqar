test_that("transect_subplot_inventories works", {

  expect_message(transect_subplot_inventories("hi"))
  expect_message(transect_subplot_inventories(faithful))

  if (nrow(suppressMessages(download_transect(5932))) != 0){
    test_transect <- download_transect(5932)
    inv <- transect_subplot_inventories(test_transect)

    expect_equal(length(inv), 6)
    expect_equal(ncol(inv[[1]]), 9)
    expect_equal(colnames(inv[[1]])[1], "scientific_name")
    expect_equal(typeof(inv[[1]]$scientific_name), "character")
    expect_equal(typeof(inv[[1]]$c), "double")
  }

})

# need to add input for all downloading functions to allow testing offline behavior
