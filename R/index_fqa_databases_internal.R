#' List all available floristic quality assessment databases with possible null results cached
#'
#' @return A data frame with 4 columns
#'
#' @import jsonlite httr
#' @importFrom memoise memoise
#'
#'
#' @noRd

index_fqa_databases_internal <- memoise::memoise(function() {
  databases_address <- "http://universalfqa.org/get/database/"
  ua <-
    httr::user_agent("https://github.com/equitable-equations/fqar")

  databases_get <- tryCatch(httr::GET(databases_address, ua),
                            error = function(e){
                              message("Unable to connect. Please check internet connection.")
                              character(0)
                            }
  )

  cl <- class(databases_get)
  if (cl != "response"){
    return(invisible(NULL))
  }

  if (httr::http_error(databases_get)) {
    message(
      paste(
        "API request to universalFQA.org failed. Error",
        httr::status_code(assessments_get)
      )
    )
    return(invisible(NULL))
  }

  databases_text <- httr::content(databases_get,
                                  "text",
                                  encoding = "ISO-8859-1")
  databases_json <- jsonlite::fromJSON(databases_text)
  list_data <- databases_json[[2]]
  databases <- as.data.frame(list_data)

  databases[, c(1, 3)] <- lapply(databases[, c(1, 3)], as.double)
  colnames(databases) <- c("database_id",
                           "region", "year",
                           "description")
  class(databases) <- c("tbl_df",
                        "tbl",
                        "data.frame")

  databases
})


