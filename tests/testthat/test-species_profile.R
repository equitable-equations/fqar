test_that("species_profile works", {

  species <- "Anemone canadensis"
  bad_list1 <- list(faithful)
  bad_list2 <- list(test_assessment, faithful)

  expect_message(species_profile(species, bad_list1))
  expect_message(species_profile(species, bad_list2))
  expect_message(species_profile(species))

  test_assessments <- list(test_assessment,
                           test_assessment2,
                           test_assessment_manual)
  good_list <- assessment_list_inventory(test_assessments)

  expect_error(species_profile("fake_species", good_list),
               "Species does not appear in any assessment. No profile generated.")

  anemone <- species_profile(species, good_list)
  expect_equal(ncol(anemone), 4)
  expect_equal(nrow(anemone), 11)
  expect_equal(names(anemone)[4], "cospecies_n")
  expect_equal(anemone$target_c[1], 4)

  anemone <- species_profile("Anemone canadensis", good_list, native = TRUE)
  expect_equal(ncol(anemone), 4)
  expect_equal(nrow(anemone), 11)
  expect_equal(names(anemone)[4], "cospecies_n")
  expect_equal(anemone$target_c[1], 4)

})
