test_that("assessment_coocurrences_summary works", {

  bad_list1 <- list(faithful)
  bad_list2 <- list(test_assessment, faithful)

  expect_message(assessment_cooccurrences_summary(bad_list1))
  expect_message(assessment_cooccurrences_summary(bad_list2))
  expect_message(assessment_cooccurrences_summary(1))

  expect_equal(nrow(suppressMessages(assessment_cooccurrences_summary(bad_list1))), 0)
  expect_equal(ncol(suppressMessages(assessment_cooccurrences_summary(bad_list1))), 16)

  test_assessments <- list(test_assessment,
                           test_assessment2,
                           test_assessment_manual)
  good_list <- assessment_list_inventory(test_assessments)

  test_cooccur <- assessment_cooccurrences_summary(good_list)

  expect_equal(ncol(test_cooccur), 16)
  expect_equal(names(test_cooccur)[2], "target_species_c")
  expect_equal(typeof(test_cooccur$target_species), "character")
  expect_equal(typeof(test_cooccur$discrepancy_c), "double")

})
