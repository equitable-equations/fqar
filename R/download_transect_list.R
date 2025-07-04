#' Download multiple floristic quality transect assessments
#'
#' \code{download_transect_list()} searches a specified floristic quality
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
#' @param ... \code{dplyr}-style filtering criteria for the desired transect
#'   assessments. The following variables may be used:
#' \itemize{
#'   \item id (numeric)
#'   \item assessment (character)
#'   \item date (date)
#'   \item site (character)
#'   \item practitioner (character)
#' }
#'
#' @param timeout Number of seconds to query UniversalFQA before timing out.
#'
#' @return A list of data frames matching the search criteria. Each is an untidy
#'   data frame in the original format of the Universal FQA website. Use
#'   \code{\link[=transect_list_glance]{transect_list_glance()}} for a tidy
#'   summary.
#'
#' @import dplyr
#' @importFrom utils txtProgressBar
#' @importFrom memoise has_cache
#' @importFrom rlang is_interactive
#'
#' @examples
#' \donttest{
#' databases <- index_fqa_databases() # Database 1 is the original 1994 Chicago edition.
#' dupont <- download_transect_list(1, site == "DuPont Natural Area")
#' }
#'
#' @export


download_transect_list <- function(database_id,
                                   ...,
                                   timeout = 4) {

  transects_summary <- index_fqa_transects(database_id,
                                           timeout = timeout)

  if (nrow(transects_summary) == 0){
    return(invisible(list()))
    message("No data returned for specified database.")
  }

  transects_requested <- transects_summary |>
    dplyr::filter(...)

  number_needed <- length(transects_requested$id) -
    sum(vapply(
      transects_requested$id,
      memoise::has_cache(download_transect_internal),
      FUN.VALUE = FALSE
    ))

  if (number_needed >= 5 && rlang::is_interactive()) {
    results <- list(0)
    pb <- utils::txtProgressBar(
      min = 0,
      max = length(transects_requested$id),
      style = 3,
      width = length(transects_requested$id),
      char = "="
    )

    for (i in seq_along(transects_requested$id)) {
      results[[i]] <-  download_transect(transects_requested$id[i],
                                         timeout = tiemout)
      utils::setTxtProgressBar(pb, i)
    }
    close(pb)
  } else {
    results <- lapply(transects_requested$id,
                      download_transect)
  }

  if (length(results) == 0){
    message("No matches found.")
    return(invisible(results))
  }

  results
}

