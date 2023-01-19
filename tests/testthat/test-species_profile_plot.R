test_that("species_profile_plot works", {

  species <- "Anemone canadensis"
  bad_list1 <- list(faithful)
  bad_list2 <- list(test_assessment, faithful)

  expect_error(species_profile_plot(species, bad_list1))
  expect_error(species_profile_plot(species, bad_list2))
  expect_error(species_profile_plot(species))

  test_assessments <- list(test_assessment,
                           test_assessment2,
                           test_assessment_manual)
  good_list <- assessment_list_inventory(test_assessments)

  expect_error(species_profile_plot("fake_species", good_list),
               "Species does not appear in any assessment. No profile plot generated.")

  p <- species_profile_plot(species, good_list)

  expect_equal(class(p), c("gg", "ggplot"))
  expect_equal(p$data$cospecies_c, 0:10)
  expect_equal(p$labels$y, "Frequency")

})
