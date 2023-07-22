#' Index floristic quality assessments that include a given species
#'
#' For any given database, \code{locate_species_assessments()} produces a data
#' frame of all floristic quality assessments publicly available at
#' \href{https://universalfqa.org/}{universalfqa.org} that include the given
#' species.
#'
#' @param database_id A numeric identifier of the desired database, as specified
#'   by \href{https://universalfqa.org/}{universalfqa.org}. The id numbers can
#'   be viewed with the
#'   \code{\link[=index_fqa_databases]{index_fqa_databases()}} function.
#' @param species The scientific name of the target plant species
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
#' \donttest{
#' locate_species_assessments("Anemone canadensis", 2)
#' }
#'
#' @export


locate_species_assessments <- function(species, database_id){
  if (!is.numeric(database_id)) {
    stop(
      "database_id must be an integer corresponding to an existing FQA database. Use index_fqa_databases() to obtain a data frame of valid options.",
      call. = FALSE
    )
  }
  if (database_id %% 1 != 0) {
    stop(
      "database_id must be an integer corresponding to an existing FQA database. Use index_fqa_databases() to obtain a data frame of valid options.",
      call. = FALSE
    )
  }

  if (!is.character(species)){
    stop(
      "species must be a string.",
      call. = FALSE
    )
  }

  indexed_fqas <- index_fqa_assessments(database_id)
  fqa_list <- download_assessment_list(database_id)
  inv_list <- assessment_list_inventory(fqa_list)

  included <- vapply(inv_list,
                     \(x) species %in% x$scientific_name,
                     logical(1))
  indexed_fqas[included, ]
}
