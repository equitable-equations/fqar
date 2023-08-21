#' Download a single floristic quality database with possible null result cached
#'
#' @param A numeric identifier of the desired floristic quality
#'   database
#'
#' @return An untidy data frame in the original format of the Universal FQA
#'   website.
#'
#' @import httr jsonlite
#' @importFrom memoise memoise
#'
#' @noRd
#'
#'

download_database_internal <- memoise::memoise(function(database_id) {
  if (!is.numeric(database_id)) {
    stop("database_id must be an integer.", call. = FALSE)
  }
  if (database_id %% 1 != 0) {
    stop("database_id must be an integer.", call. = FALSE)
  }
  if (database_id == -40000) {
    return(invisible(NULL))
  } # for testing memoisation

  database_address <-
    paste0("http://universalfqa.org/get/database/",
           database_id)
  ua <-
    httr::user_agent("https://github.com/equitable-equations/fqar")

  database_get <- tryCatch(httr::GET(database_address, ua),
                           error = function(e){
                             message("Unable to connect. Please check internet connection.")
                             character(0)
                           }
  )

  cl <- class(database_get)
  if (cl != "response"){
    return(invisible(NULL))
  }

  if (httr::http_error(database_get)) {
    message(
      paste(
        "API request to universalFQA.org failed. Error",
        httr::status_code(assessments_get)
      )
    )
    return(invisible(NULL))
  }

  database_text <- httr::content(database_get,
                                 "text",
                                 encoding = "ISO-8859-1")
  database_json <- jsonlite::fromJSON(database_text)
  list_data <- database_json[[2]]

  if ((list_data[[1]] == "The requested assessment is not public") &
      (!is.na(list_data[[1]]))) {
    stop("The requested assessment is not public", call. = FALSE)
  }

  max_length <-
    max(unlist(lapply(list_data, length))) # determines how wide the df must be
  list_data <- lapply(list_data,
                      function(x) {
                        length(x) <- max_length
                        unlist(x)
                      })

  db_out <- as.data.frame(do.call(rbind, list_data))

  if (db_out[5, 2] == 0)
    warning("Specified database is empty.",
            call. = FALSE)

  db_out
})
