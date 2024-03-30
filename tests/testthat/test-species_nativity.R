test_that("species_nativity works", {

  species <- "Anemone canadensis"
  species2 <- "Andromeda glaucophylla"
  species3 <- "Abelmoschus esculentus"

  expect_error(species_nativity(species),
               "Either database_id or database_inventory must be specified.")
  expect_error(species_nativity(species, database_inventory = faithful),
               "database_inventory must be a species inventory in the format provided by database_inventory().")
  expect_error(species_nativity(species, database_id = "hi"),
               "database_id must be an integer.")

  skip_if_offline()

  db <- suppressMessages(download_database(1))
  db_inv <- suppressMessages(database_inventory(db))

  expect_error(species_nativity(species, 149, db_inv),
               "database_id or database_inventory cannot both be specified.")
  expect_true(is.na(suppressMessages(species_nativity("fake_species",
                                               database_inventory = db_inv))))

  if (!is.na(suppressMessages(species_nativity(species, 149)))) {
    expect_equal(species_nativity(species, 149), "native")
    expect_equal(species_nativity(species3, 149), "non-native")
    expect_equal(species_nativity(species2, database_inventory = db_inv), "native")
    expect_message(species_nativity("fake_species", database_inventory = db_inv),
                   "Species not found in specified database.")
  } else {
    # for when database download fails
    expect_message(species_nativity(species, 149))
  }
})
