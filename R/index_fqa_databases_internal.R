#' List all available floristic quality assessment databases
#'
#' @return A data frame with 4 columns
#'
#' @import jsonlite httr
#' @importFrom memoise memoise
#'
#'
#' @noRd


index_fqa_databases_internal <-
  memoise::memoise(function(timeout = 4) {

    if(!is.numeric(timeout)){
      stop("timeout must be an integer.",
           call. = FALSE)
    }

    empty_df <- data.frame(database_id = numeric(0),
                           region = character(0),
                           year = numeric(0),
                           description = character(0)
    )
    class(empty_df) <- c("tbl_df",
                         "tbl",
                         "data.frame")

    databases_address <- "http://universalfqa.org/get/database/"
    ua <-
      httr::user_agent("https://github.com/equitable-equations/fqar")

    databases_get <- tryCatch(httr::GET(databases_address,
                                        ua,
                                        timeout(timeout)),
                              error = function(e){
                                message("No response from UniversalFQA.org. Please check internet connection.")
                                character(0)
                              }
    )

    cl <- class(databases_get)
    if (cl != "response"){
      return(invisible(empty_df))
    }

    if (httr::http_error(databases_get)) {
      message(
        paste(
          "API request to universalFQA.org failed. Error",
          httr::status_code(assessments_get)
        )
      )
      return(invisible(empty_df))
    }

    databases_text <- httr::content(databases_get,
                                    "text",
                                    encoding = "ISO-8859-1")
    databases_json <- jsonlite::fromJSON(databases_text)
    list_data <- databases_json[[2]]
    databases <- as.data.frame(list_data)

    databases[, c(1, 3)] <- lapply(databases[, c(1, 3)], as.double)
    colnames(databases) <- c("database_id",
                             "region",
                             "year",
                             "description")
    class(databases) <- c("tbl_df",
                          "tbl",
                          "data.frame")

    databases
  })


