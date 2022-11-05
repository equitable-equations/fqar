# Code to build the chicago data set

chicago_list <- download_assessment_list(database_id = 149)
chicago <- assessment_list_glance(chicago_list)
chicago$title[499] <- "Dune Acres - Elmore East" # manually making the hyphen standard

usethis::use_data(chicago, overwrite = TRUE, ascii = TRUE)


# Code to build the missouri data set

missouri_list <- download_assessment_list(database_id = 63)
missouri <- assessment_list_glance(missouri_list)

usethis::use_data(missouri, overwrite = TRUE, ascii = TRUE)
