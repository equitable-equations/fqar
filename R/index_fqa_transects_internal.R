#' List all available public floristic quality transect assessments with possible null cached
#'
#' @param database_id A numeric identifier of the desired database
#'
#' @return A data frame with 5 columns
#'
#' @import jsonlite httr
#' @importFrom memoise memoise
#'
#' @noRd


index_fqa_transects_internal <- memoise::memoise(function(database_id) {

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
  class(empty_df) <- c("tbl_df",
                       "tbl",
                       "data.frame")

  empty_df$date <- as.Date(empty_df$date)

  if (database_id == -40000) {
    return(invisible(empty_df))
  } # for testing offline behavior

  trans_address <- paste0("http://universalfqa.org/get/database/",
                          database_id,
                          "/transect")
  ua <-
    httr::user_agent("https://github.com/equitable-equations/fqar")

  trans_get <- tryCatch(httr::GET(trans_address,
                                  ua,
                                  timeout(2)),
                        error = function(e){
                          message("No response from universalFQA.org. Please check internet connection.")
                          character(0)
                        }
  )

  cl <- class(trans_get)
  if (cl != "response"){
    return(invisible(empty_df))
  }

  if (httr::http_error(trans_get)) {
    message(
      paste(
        "API request to universalFQA.org failed. Error",
        httr::status_code(assessments_get)
      )
    )
    return(invisible(empty_df))
  }

  trans_text <- httr::content(trans_get,
                              "text",
                              encoding = "ISO-8859-1")
  trans_json <- jsonlite::fromJSON(trans_text)
  list_data <- trans_json[[2]]

  transect_summary <- as.data.frame(list_data)

  if (nrow(transect_summary) == 0) {
    message("No data associated with specified database_id.")
    return(invisible(empty_df))
  }

  colnames(transect_summary) <- c("id",
                                  "assessment",
                                  "date",
                                  "site",
                                  "practitioner")
  transect_summary$id <- as.double(transect_summary$id)
  transect_summary$date[transect_summary$date == "0000-00-00"] <-
    NA
  transect_summary$date <- as.Date(transect_summary$date)
  class(transect_summary) <- c("tbl_df",
                               "tbl",
                               "data.frame")

  transect_summary
})






