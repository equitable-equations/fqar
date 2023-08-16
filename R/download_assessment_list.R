#' Download multiple floristic quality assessments
#'
#' \code{download_assessment_list()} searches a specified floristic quality
#' assessment database and retrieves all matches from
#' \href{https://universalfqa.org/}{universalfqa.org}. Download speeds from that
#' website may be slow, causing delays in the evaluation of this function.
#'
#' @param database_id Numeric identifier of the desired floristic quality
#'   assessment database, as specified by
#'   \href{https://universalfqa.org/}{universalfqa.org}. Database id numbers can
#'   be viewed with the
#'   \code{\link[=index_fqa_databases]{index_fqa_databases()}} function.
#'
#' @param ... \code{dplyr}-style filtering criteria for the desired assessments.
#'   The following variables may be used:
#' \itemize{
#'   \item id (numeric)
#'   \item assessment (character)
#'   \item date (date)
#'   \item location (character)
#'   \item practitioner (character)
#' }
#'
#' @return A list of data frames matching the search criteria. Each is an untidy
#'   data frame in the original format of the Universal FQA website. Use
#'   \code{\link[=assessment_list_glance]{assessment_list_glance()}} for a tidy
#'   summary.
#'
#' @import dplyr utils
#' @importFrom memoise has_cache
#'
#' @examples
#' \donttest{
#' databases <- index_fqa_databases # Note database 1 is the original 1994 Chicago edition.
#' somme_assessments <- download_assessment_list(1, site == "Somme Woods")
#' somme_summary <- assessment_list_glance(somme_assessments)
#' }
#'
#' @export


download_assessment_list <- function(database_id, ...) {
  inventories_summary <- index_fqa_assessments(database_id)

  inventories_requested <- inventories_summary |>
    dplyr::filter(...)

  number_needed <- length(inventories_requested$id) -
    sum(vapply(
      inventories_requested$id,
      memoise::has_cache(download_assessment),
      FUN.VALUE = FALSE
    ))

  if (number_needed >= 5 && rlang::is_interactive()) {
    results <- list(0)
    pb <- utils::txtProgressBar(
      min = 0,
      max = length(inventories_requested$id),
      style = 3,
      width = length(inventories_requested$id),
      char = "="
    )
    for (i in seq_along(inventories_requested$id)) {
      results[[i]] <-  download_assessment(inventories_requested$id[i])
      utils::setTxtProgressBar(pb, i)
    }
    close(pb)
  } else {
    results <- lapply(inventories_requested$id,
                      download_assessment)
  }

  if (length(results) == 0)
    warning("No matches found. Empty list returned.", call. = FALSE)

  results
}
