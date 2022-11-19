#' List all available floristic quality assessment databases
#'
#' \code{index_fqa_databases()} produces a data frame showing all floristic
#' quality assessment databases publicly available at
#' \href{https://universalfqa.org/}{universalfqa.org}.
#'
#' @return A data frame with 4 columns:
#' \itemize{
#'   \item database_id (numeric)
#'   \item region (character)
#'   \item year (numeric)
#'   \item description (character)
#' }
#'
#' @examples
#' databases <- index_fqa_databases()
#'
#' @import jsonlite httr
#'
#' @export

index_fqa_databases <- function() {

  databases_address <- "http://universalfqa.org/get/database/"
  ua <- httr::user_agent("https://github.com/equitable-equations/fqar")

  databases_get <- httr::GET(databases_address, ua)

  if (httr::http_error(databases_get)) {
    stop(paste("API request to universalFQA.org failed. Error",
               httr::status_code(databases_get)),
         call. = FALSE
    )
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
}
