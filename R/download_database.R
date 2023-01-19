#' Download a single floristic quality database
#'
#' \code{download_database()} retrieves a specified floristic quality database
#' from \href{https://universalfqa.org/}{universalfqa.org}. A list of available
#' databases can be found using the
#' \code{\link[=index_fqa_databases]{index_fqa_databases()} } function.
#'
#' @param database_id A numeric identifier of the desired floristic quality
#'   database, as specified by
#'   \href{https://universalfqa.org/}{universalfqa.org}. ID numbers for
#'   databases recognized this site can be viewed with the
#'   \code{\link[=index_fqa_databases]{index_fqa_databases()}} function.
#'
#' @return An untidy data frame in the original format of the Universal FQA
#'   website. Use \code{\link[=database_glance]{database_glance()}} for a tidy
#'   summary and \code{\link[=database_inventory]{database_inventory()}} for
#'   species-level data.
#'
#' @import jsonlite httr
#' @importFrom memoise memoise
#'
#' @examples
#' \donttest{
#' databases <- index_fqa_databases()
#' # Note database 1 is the original 1994 Chicago edition.
#'
#' chicago_database <- download_database(1)
#' }
#'
#' @export

download_database <- memoise::memoise(function(database_id) {
  if (!is.numeric(database_id)) {
    stop("database_id must be an integer.", call. = FALSE)
  }
  if (database_id %% 1 != 0) {
    stop("database_id must be an integer.", call. = FALSE)
  }

  database_address <-
    paste0("http://universalfqa.org/get/database/",
           database_id)
  ua <-
    httr::user_agent("https://github.com/equitable-equations/fqar")

  database_get <- httr::GET(database_address, ua)
  if (httr::http_error(database_get)) {
    stop(
      paste(
        "API request to universalFQA.org failed. Error",
        httr::status_code(database_get)
      ),
      call. = FALSE
    )
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

