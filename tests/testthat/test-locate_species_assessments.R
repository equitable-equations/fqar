test_that("locate_species_assessment works", {

  expect_error(locate_species_assessment(2, 5))
  expect_error(locate_species_assessment("hi", 1.5))
  expect_error(locate_species_assessment("hi"))

  skip_on_cran()

  species <- "Anemone canadensis"
  assessments <- locate_species_assessments(species, 2)

  expect_equal(ncol(assessments), 5)
  expect_equal(names(assessments),
               c("id", "assessment", "date", "site", "practitioner"))
  expect_equal(class(assessments[[1]]), "numeric")
  expect_equal(class(assessments[[3]]), "Date")
  expect_equal(class(assessments[[5]]), "character")
})
