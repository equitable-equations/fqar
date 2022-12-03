test_that("species_phys works", {

  species <- "Anemone canadensis"
  species2 <- "Andromeda glaucophylla"
  species3 <- "Abelmoschus esculentus"

  db <- download_database(1)
  db_inv <- database_inventory(db)

  expect_error(species_phys(species),
               "Either database_id or database_inventory must be specified.")
  expect_error(species_phys(species, 149, db_inv),
               "database_id or database_inventory cannto both be specified.")
  expect_error(species_phys(species, database_inventory = faithful),
               "database_inventory must be a species inventory in the format provided by database_inventory().")
  expect_error(species_phys(species, database_id = "hi"),
               "database_id must be an integer.")
  expect_error(species_phys("fake_species", database_inventory = db_inv),
               "Species not found in specified database.")

  expect_equal(species_phys(species, 149), "forb")
  expect_equal(species_phys(species3, 149), "forb")
  expect_equal(species_phys(species2, database_inventory = db_inv), "shrub")

})
