#' List all available public floristic quality assessments
#'
#' @param database_id A numeric identifier of the desired database
#' @return A data frame with 5 columns
#'
#' @import jsonlite httr
#' @importFrom memoise memoise
#'
#' @noRd


index_fqa_assessments_internal <- memoise::memoise(function(database_id) {

  if (!is.numeric(database_id)) {
    stop(
      "database_id must be an integer corresponding to an existing FQA database. Use index_fqa_databases() to obtain a data frame of valid options.",
      call. = FALSE
    )
  }

  if (database_id %% 1 != 0) {
    stop(
      "database_id must be an integer corresponding to an existing FQA database. Use index_fqa_databases() to obtain a data frame of valid options.",
      call. = FALSE
    )
  }

  empty_df <- data.frame(id = numeric(0),
    assessment = character(0),
    date = numeric(0),
    site = character(0),
    practitioner = character(0)
  )

  empty_df$date <- as.Date(empty_df$Date)

  if (database_id == -40000) {
    return(invisible(empty_df))
  } # for testing offline behavior

  assessments_address <-
    paste0("http://universalfqa.org/get/database/",
           database_id,
           "/inventory")
  ua <-
    httr::user_agent("https://github.com/equitable-equations/fqar")

  assessments_get <- tryCatch(httr::GET(assessments_address, ua),
                              error = function(e){
                                message("Unable to connect. Please check internet connection.")
                                character(0)
                              }
  )

  cl <- class(assessments_get)
  if (cl != "response"){
    return(invisible(empty_df))
  }

  if (httr::http_error(assessments_get)) {
    message(
      paste(
        "API request to universalFQA.org failed. Error",
        httr::status_code(assessments_get)
      )
    )
    return(invisible(empty_df))
  }

  assessments_text <- httr::content(assessments_get,
                                    "text",
                                    encoding = "ISO-8859-1")
  assessments_json <- jsonlite::fromJSON(assessments_text)
  list_data <- assessments_json[[2]]

  inventories_summary <- as.data.frame(list_data)

  if (nrow(inventories_summary) == 0) {
    message("No data associated with specified database_id")
    return(invisible(empty_df))
  }

  colnames(inventories_summary) <- c("id",
                                     "assessment",
                                     "date",
                                     "site",
                                     "practitioner")
  inventories_summary$id <- as.double(inventories_summary$id)
  inventories_summary$date[inventories_summary$date == "0000-00-00"] <- NA
  inventories_summary$date <- as.Date(inventories_summary$date)
  class(inventories_summary) <- c("tbl_df",
                                  "tbl",
                                  "data.frame")

  inventories_summary
})





