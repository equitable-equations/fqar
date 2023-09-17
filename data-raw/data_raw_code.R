# Code to build the chicago data set
library(dplyr)

chicago_list <- download_assessment_list(database_id = 149)
chicago <- assessment_list_glance(chicago_list)
chicago <- chicago |>
  mutate(across(where(is.character),
                \(x) iconv(x, to = "ASCII//TRANSLIT"))) |>
  filter(is.na(custom_fqa_db_name))

usethis::use_data(chicago, overwrite = TRUE, ascii = TRUE)


# Code to build the missouri data set

missouri_list <- download_assessment_list(database_id = 63)
missouri <- assessment_list_glance(missouri_list)
missouri <- missouri |>
  mutate(across(where(is.character),
                \(x) iconv(x, to = "ASCII//TRANSLIT"))) |>
  filter(is.na(custom_fqa_db_name))

usethis::use_data(missouri,
                  overwrite = TRUE,
                  ascii = TRUE)
