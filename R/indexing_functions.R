#' Obtain a data frame of all existing FQA databases
#'
#' Downloads a data frame of public floristic quality assessment databases from \href{https://universalfqa.org/}{universalfqa.org}.
#'
#' @return A data frame with four columns:
#' \itemize{
#'   \item database_id (numeric)
#'   \item region (character)
#'   \item year (numeric)
#'   \item description (character)
#' }
#'
#' @examples
#' \dontrun{
#' databases <- download_fqa_databases()
#' }
#'
#' @import jsonlite
#'
#' @export
download_fqa_databases <- function() {
  databases_address <- "http://universalfqa.org/get/database/"
  databases_raw <- jsonlite::fromJSON(databases_address)
  databases <- data.frame(databases_raw$data)
  databases[, c(1, 3)] <- lapply(databases[, c(1, 3)], as.double)
  colnames(databases) <-
    c("database_id", "region", "year", "description")
  class(databases) <- c("tbl_df", "tbl", "data.frame")
  databases
}


#' Obtain a data frame of all available public FQA assessments
#'
#' Downloads a data frame of publicly-available inventory assessments for a given FQA database from \href{universalfqa.org}{https://universalfqa.org/}.
#' Databases should be specified by their \code{database_id} number, which can be obtained with the \code{\link{download_fqa_databases}} function.
#'
#' @param database_id A numeric identifier of the desired database, as specified by \href{https://universalfqa.org/}{universalfqa.org}. The id numbers can be viewed with the \code{\link{download_fqa_databases}} function.
#'
#' @return A data frame with five columns:
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
#'
#' databases <- download_fqa_databases() # A recent Chicago database has id_number 149
#' chicago_2017_assessments <- download_fqa_assessments(149)
#' }
#'
#' @export
download_fqa_assessments <- function(database_id) {
  if (!is.numeric(database_id)) {stop("database_id must be an integer corresponding to an existing FQA database. Use download_fqa_databases() to obtain a data frame of valid options.", call. = FALSE)}
  if (database_id %% 1 != 0) {stop("database_id must be an integer corresponding to an existing FQA database. Use download_fqa_databases() to obtain a data frame of valid options.", call. = FALSE)}
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

#' Obtain a data frame of all available public FQA transect assessments
#'
#' Downloads a data frame of publicly-available transect assessments for a given FQA database from \href{https://universalfqa.org/}{universalfqa.org}.
#' Databases should be specified by their \code{database_id} number, which can be obtained with the \code{\link{download_fqa_databases}} function.
#'
#' @param database_id A numeric identifier of the desired database, as specified by \href{https://universalfqa.org/}{universalfqa.org}. The id numbers can be viewed with the \code{\link{download_fqa_databases}} function.
#'
#' @return A data frame with five columns:
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
#' databases <- download_fqa_databases()
#' # Note that the most current Chicago database has id_number 149.
#' chicago_2017_transects <- download_fqa_assessments(149)
#' }
#'
#' @export
download_fqa_transects <- function(database_id) {
  if (!is.numeric(database_id)) {stop("database_id must be an integer corresponding to an existing FQA database. Use download_fqa_databases() to obtain a data frame of valid options.", call. = FALSE)}
  if (database_id %% 1 != 0) {stop("database_id must be an integer corresponding to an existing FQA database. Use download_fqa_databases() to obtain a data frame of valid options.", call. = FALSE)}
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
