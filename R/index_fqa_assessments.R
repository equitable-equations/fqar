#' List all available public floristic quality assessments
#'
#' For any given database, \code{index_fqa_assessments()} produces a data frame
#' of all floristic quality assessments publicly available at
#' \href{https://universalfqa.org/}{universalfqa.org}.
#'
#' @param database_id A numeric identifier of the desired database, as specified
#'   by \href{https://universalfqa.org/}{universalfqa.org}. The id numbers can
#'   be viewed with the
#'   \code{\link[=index_fqa_databases]{index_fqa_databases()}} function.
#'
#' @return A data frame with 5 columns:
#' \itemize{
#'   \item id (numeric)
#'   \item assessment (character)
#'   \item date (date)
#'   \item site (character)
#'   \item practitioner (character)
#'   }
#'
#' @import jsonlite httr
#' @importFrom memoise memoise
#'
#' @examples
#' \donttest{
#' databases <- index_fqa_databases()
#' # Note that the 2017 Chicago database has id_number 149
#' chicago_2017_assessments <- index_fqa_assessments(149)
#' }
#'
#' @export

index_fqa_assessments <- memoise(

  function(database_id) {

    if (!is.numeric(database_id)) {
      stop("database_id must be an integer corresponding to an existing FQA database. Use index_fqa_databases() to obtain a data frame of valid options.", call. = FALSE)
    }
    if (database_id %% 1 != 0) {
      stop("database_id must be an integer corresponding to an existing FQA database. Use index_fqa_databases() to obtain a data frame of valid options.", call. = FALSE)
    }

    assessments_address <- paste0("http://universalfqa.org/get/database/",
                                  database_id,
                                  "/inventory")
    ua <- httr::user_agent("https://github.com/equitable-equations/fqar")

    assessments_get <- httr::GET(assessments_address, ua)
    if (httr::http_error(assessments_get)) {
      stop(paste("API request to universalFQA.org failed. Error",
                 httr::status_code(assessments_get)),
           call. = FALSE
      )
    }
    assessments_text <- httr::content(assessments_get,
                                      "text",
                                      encoding = "ISO-8859-1")
    assessments_json <- jsonlite::fromJSON(assessments_text)
    list_data <- assessments_json[[2]]

    inventories_summary <- as.data.frame(list_data)

    if (nrow(inventories_summary) == 0) {
      stop("no data associated with specified database_id.", call. = FALSE)
    }

    colnames(inventories_summary) <- c("id", "assessment",
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
  }
)
