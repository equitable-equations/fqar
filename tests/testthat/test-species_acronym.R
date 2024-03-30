test_that("species_acronym works", {

  species <- "Anemone canadensis"
  species2 <- "Andropogon gerardii"
  species3 <- "Abelmoschus esculentus"

  expect_error(species_acronym(species),
               "Either database_id or database_inventory must be specified.")
  expect_error(species_acronym(species, database_inventory = faithful),
               "database_inventory must be a species inventory in the format provided by database_inventory().")
  expect_error(species_acronym(species, database_id = "hi"),
               "database_id must be an integer.")

  skip_if_offline()

  db <- suppressMessages(download_database(149))
  db_inv <- suppressMessages(database_inventory(db))

  expect_error(species_acronym(species, 149, db_inv),
               "database_id and database_inventory cannot both be specified.")
  expect_true(is.na(suppressMessages(species_acronym("fake_species",
                                                     database_inventory = db_inv))))

  if (!is.na(suppressMessages(species_acronym(species, 149)))) {
    expect_equal(species_acronym(species, 149), "ANECAN") # for when database download succeeds
    expect_equal(species_acronym(species3, 149), "ABEESC")
    expect_equal(species_acronym(species2, database_inventory = db_inv), "ANDGER")
    expect_message(species_acronym("fake_species", database_inventory = db_inv),
                   "Species not found in specified database.")
  } else {
    # for when database download fails
    expect_message(species_acronym(species, 149))
  }

})
