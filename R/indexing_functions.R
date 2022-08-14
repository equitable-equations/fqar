#' List all available floristic quality assessment databases
#'
#' \code{index_fqa_databases} produces a data frame showing all floristic
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
#' \dontrun{
#' databases <- index_fqa_databases()
#' }
#'
#' @import jsonlite
#'
#' @export

index_fqa_databases <- function() {
  databases_address <- "http://universalfqa.org/get/database/"
  databases_raw <- jsonlite::fromJSON(databases_address)
  databases <- data.frame(databases_raw$data)
  databases[, c(1, 3)] <- lapply(databases[, c(1, 3)], as.double)
  colnames(databases) <-
    c("database_id", "region", "year", "description")
  class(databases) <- c("tbl_df", "tbl", "data.frame")
  databases
}



#' List all available public floristic quality assessments
#'
#' For any given database, \code{index_fqa_assessments} produces a data frame
#' of all floristic quality assessments publicly available at
#' \href{https://universalfqa.org/}{universalfqa.org}.
#'
#' @param database_id A numeric identifier of the desired database, as specified by \href{https://universalfqa.org/}{universalfqa.org}. The id numbers can be viewed with the \code{\link{index_fqa_databases}} function.
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
#' @examples
#' \dontrun{
#' # The 2017 Chicago database has id_number 149
#' databases <- index_fqa_databases()
#' chicago_2017_assessments <- index_fqa_assessments(149)
#' }
#'
#' @export

index_fqa_assessments <- function(database_id) {
  if (!is.numeric(database_id)) {stop("database_id must be an integer corresponding to an existing FQA database. Use index_fqa_databases() to obtain a data frame of valid options.", call. = FALSE)}
  if (database_id %% 1 != 0) {stop("database_id must be an integer corresponding to an existing FQA database. Use index_fqa_databases() to obtain a data frame of valid options.", call. = FALSE)}
  inv_address <- paste0("http://universalfqa.org/get/database/", database_id, "/inventory")
  inv_raw_json <- jsonlite::fromJSON(inv_address)
  inventories_summary <- data.frame(inv_raw_json$data)
  if (nrow(inventories_summary) == 0) {stop("no data associated with specified database_id.", call. = FALSE)}
  colnames(inventories_summary) <-
    c("id", "assessment", "date", "site", "practitioner")
  inventories_summary$id <- as.double(inventories_summary$id)
  inventories_summary$date[inventories_summary$date == "0000-00-00"] <- NA
  inventories_summary$date <- as.Date(inventories_summary$date)
  class(inventories_summary) <- c("tbl_df", "tbl", "data.frame")
  inventories_summary
}



#' List all available public floristic quality transect assessments
#'
#' For any given database, \code{index_fqa_transects} produces a data frame
#' of all floristic quality transect assessments publicly available at
#' \href{https://universalfqa.org/}{universalfqa.org}.
#'
#' @param database_id A numeric identifier of the desired database, as specified by \href{https://universalfqa.org/}{universalfqa.org}. The id numbers can be viewed with the \code{\link{index_fqa_databases}} function.
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
#' @examples
#' \dontrun{
#' databases <- index_fqa_databases()
#' # Note that the most current Chicago database has id_number 149.
#' chicago_2017_transects <- index_fqa_assessments(149)
#' }
#'
#' @export

index_fqa_transects <- function(database_id) {
  if (!is.numeric(database_id)) {stop("database_id must be an integer corresponding to an existing FQA database. Use index_fqa_databases() to obtain a data frame of valid options.", call. = FALSE)}
  if (database_id %% 1 != 0) {stop("database_id must be an integer corresponding to an existing FQA database. Use index_fqa_databases() to obtain a data frame of valid options.", call. = FALSE)}
  trans_address <- paste0("http://universalfqa.org/get/database/", database_id, "/transect")
  trans_raw_json <- jsonlite::fromJSON(trans_address)
  transect_summary <- data.frame(trans_raw_json$data)
  if (nrow(transect_summary) == 0) {stop("no data associated with specified database_id.")}
  colnames(transect_summary) <-
    c("id", "assessment", "date", "site", "practitioner")
  transect_summary$id <- as.double(transect_summary$id)
  transect_summary$date[transect_summary$date == "0000-00-00"] <- NA
  transect_summary$date <- as.Date(transect_summary$date)
  class(transect_summary) <- c("tbl_df", "tbl", "data.frame")
  transect_summary
}
