# Code to generate internal data sets

library(readr)
library(usethis)

test_assessment <- read_csv("data-raw/test_assessment.csv")
test_assessment2 <- read_csv("data-raw/test_assessment2.csv")
test_assessment_manual <- read_csv("data-raw/test_assessment_manual.csv",
                                   skip_empty_rows = FALSE)
test_transect <- read_csv("data-raw/test_transect.csv")
test_database <- read_csv("data-raw/test_database.csv")


use_data(test_assessment,
         test_assessment2,
         test_assessment_manual,
         test_transect,
         test_database,
         internal = TRUE,
         overwrite = TRUE)
