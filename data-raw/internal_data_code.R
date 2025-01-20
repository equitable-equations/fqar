# Code to generate internal data sets

library(readr)
library(usethis)

test_assessment <- read_csv("data-raw/test_assessment.csv")
test_assessment2 <- read_csv("data-raw/test_assessment2.csv")
test_assessment_manual <- read_delim("data-raw/test_assessment_manual.csv",
                                     skip_empty_rows = FALSE,
                                     delim = "***")

test_transect <- read_csv("data-raw/test_transect.csv")

test_database <- read_delim("data-raw/test_database.csv",
                            delim = "***")
test_database <- as.data.frame(test_database)

test_inventory <- read_csv("data-raw/test_inventory.csv")


use_data(test_assessment,
         test_assessment2,
         test_assessment_manual,
         test_transect,
         test_database,
         test_inventory,
         internal = TRUE,
         overwrite = TRUE)
