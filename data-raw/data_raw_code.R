# Code to build the chicago data set

chicago_list <- download_assessment_list(database_id = 149)
chicago <- assessment_list_glance(chicago_list)

use_this::use_data(chicago, overwrite = TRUE)


# Code to build the missouri data set

missouri_list <- download_assessment_list(database_id = 63)
missouri <- assessment_list_glance(missouri_list)

use_this::use_data(missouri, overwrite = TRUE)
