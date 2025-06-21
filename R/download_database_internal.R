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


download_database_internal <-
  memoise::memoise(function(database_id,
                            timeout = 5) {

    if (!is.numeric(database_id)) {
      stop("database_id must be an integer.",
           call. = FALSE
      )
    }

    if (database_id %% 1 != 0) {
      stop("database_id must be an integer.",
           call. = FALSE
      )
    }

    if(!is.numeric(timeout)){
      stop("timeout must be an integer.",
           call. = FALSE)
    }

    empty <- data.frame(V1 = character(0),
                        V2 = character(0),
                        V3 = character(0),
                        V4 = character(0),
                        V5 = character(0),
                        V6 = character(0),
                        V7 = character(0),
                        V8 = character(0),
                        V9 = character(0))
    class(empty) <- c("tbl_df",
                      "tbl",
                      "data.frame")

    if (database_id == -40000){
      return(invisible(empty))
    } # for testing internet errors

    database_address <-
      paste0("http://universalfqa.org/get/database/",
             database_id)
    ua <-
      httr::user_agent("https://github.com/equitable-equations/fqar")

    database_get <- tryCatch(httr::GET(database_address,
                                       ua,
                                       httr::timeout(timeout)),
                             error = function(e){
                               message("No response from universalFQA.org. Please check internet connection.")
                               character(0)
                             }
    )

    cl <- class(database_get)
    if (cl != "response"){
      return(invisible(empty))
    }

    if (httr::http_error(database_get)) {
      message(
        paste(
          "API request to universalFQA.org failed. Error",
          httr::status_code(database_get)
        )
      )
      return(invisible(empty))
    }

    database_text <- httr::content(database_get,
                                   "text",
                                   encoding = "ISO-8859-1")
    if (database_text == "" |
        database_text == "{ \"status\" : \"success\", \"data\" : }") {
      message("No data returned. Specified database may be empty")
      return(invisible(empty))
    }

    database_json <- jsonlite::fromJSON(database_text)
    list_data <- database_json[[2]]

    if ((list_data[[1]] == "The requested assessment is not public") &
        (!is.na(list_data[[1]]))) {
      message("The requested assessment is not public.")
      return(invisible(empty))
    }

    max_length <-
      max(unlist(lapply(list_data, length))) # determines how wide the df must be
    list_data <- lapply(list_data,
                        function(x) {
                          length(x) <- max_length
                          unlist(x)
                        })

    db_out <- as.data.frame(do.call(rbind, list_data))

    if (db_out[5, 2] == 0){
      message("Specified database is empty.")
    }

    class(db_out) <- c("tbl_df",
                       "tbl",
                       "data.frame")

    db_out
  })
