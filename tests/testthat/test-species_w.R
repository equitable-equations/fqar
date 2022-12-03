test_that("species_w works", {

  species <- "Anemone canadensis"
  species2 <- "Andromeda glaucophylla"
  db <- download_database(1)
  db_inv <- database_inventory(db)

  expect_error(species_w(species),
               "Either database_id or database_inventory must be specified.")
  expect_error(species_w(species, 149, db_inv),
               "database_id or database_inventory cannto both be specified.")
  expect_error(species_w(species, database_inventory = faithful),
               "database_inventory must be a species inventory in the format provided by database_inventory().")
  expect_error(species_w(species, database_id = "hi"),
               "database_id must be an integer.")
  expect_error(species_w("fake_species", database_inventory = db_inv),
               "Species not found in specified database.")

  expect_equal(species_w(species, 149), -1)
  expect_equal(species_w(species2, database_inventory = db_inv), -5)

})
