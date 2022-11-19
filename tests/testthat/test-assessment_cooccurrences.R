test_that("assessment_cooccurrences works", {

  bad_list1 <- list(faithful)
  bad_list2 <- list(test_assessment, faithful)

  expect_error(assessment_cooccurrences(bad_list1))
  expect_error(assessment_cooccurrences(bad_list2))
  expect_error(assessment_cooccurrences(1))

  test_assessments <- list(test_assessment,
                           test_assessment2,
                           test_assessment_manual)
  good_list <- assessment_list_inventory(test_assessments)

  test_cooccur <- assessment_cooccurrences(good_list)

  expect_equal(ncol(test_cooccur), 12)
  expect_equal(nrow(test_cooccur), 5354)
  expect_equal(names(test_cooccur)[2], "target_species_c")
  expect_equal(typeof(test_cooccur$target_species), "character")
  expect_equal(typeof(test_cooccur$cospecies_c), "double")

})
