test_that("species_c works", {

  species <- "Anemone canadensis"
  species2 <- "Andromeda glaucophylla"

  expect_error(species_c(species),
               "Either database_id or database_inventory must be specified.")
  expect_error(species_c(species, database_inventory = faithful),
               "database_inventory must be a species inventory in the format provided by database_inventory().")
  expect_error(species_c(species, database_id = "hi"),
               "database_id must be an integer.")
  expect_error(species_c(species, database_inventory = faithful),
               "database_inventory must be a species inventory in the format provided by database_inventory().")
  expect_error(species_c(species, database_id = "hi"),
               "database_id must be an integer.")

  skip_if_offline()

  db <- suppressMessages(download_database(1))
  db_inv <- suppressMessages(database_inventory(db))

  expect_error(species_c(species, 149, db_inv),
               "database_id or database_inventory cannot both be specified.")
  expect_true(is.na(suppressMessages(species_c("fake_species",
                              database_inventory = db_inv))))

  if (!is.na(suppressMessages(species_c(species, 149)))) {
    expect_equal(species_c(species, 149), 4) # if server responds
    expect_equal(species_c(species2, database_inventory = db_inv), 10)
    expect_message(species_c("fake_species", database_inventory = db_inv),
                   "Species not found in specified database.")
  } else {
    expect_message(species_c(species, 149))
  }

})
