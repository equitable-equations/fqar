test_that("species_acronym works", {

  species <- "Anemone canadensis"
  species2 <- "Andromeda glaucophylla"
  species3 <- "Abelmoschus esculentus"

  db <- download_database(1)
  db_inv <- database_inventory(db)

  expect_error(species_acronym(species),
               "Either database_id or database_inventory must be specified.")
  expect_error(species_acronym(species, 149, db_inv),
               "database_id and database_inventory cannot both be specified.")
  expect_error(species_acronym(species, database_inventory = faithful),
               "database_inventory must be a species inventory in the format provided by database_inventory().")
  expect_error(species_acronym(species, database_id = "hi"),
               "database_id must be an integer.")
  expect_message(species_acronym("fake_species", database_inventory = db_inv),
               "Species not found in specified database.")

  expect_equal(species_acronym(species, 149), "ANECAN")
  expect_equal(species_acronym(species3, 149), "ABEESC")
  expect_equal(species_acronym(species2, database_inventory = db_inv), "ANDGLA")

})
