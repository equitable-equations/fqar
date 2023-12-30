#' Generate a summary of co-occurrences in various assessment inventories
#'
#' \code{assessment_coccurrences_summary()} accepts a list of species
#' inventories downloaded from
#' \href{https://universalfqa.org/}{universalfqa.org} and returns a summary of
#' the co-occurrences of each target species. Repeated co-occurrences across
#' multiple assessments are included in summary calculations, but self
#' co-occurrences are not.
#'
#' @param inventory_list A list of site inventories having the format of
#'   \code{\link[=assessment_list_inventory]{assessment_list_inventory()}}.
#'
#' @return A data frame with 16 columns:
#' \itemize{
#' \item target_species (character)
#' \item target_species_c (numeric)
#' \item target_species_nativity (character)
#' \item target_species_n (numeric)
#' \item cospecies_n (numeric)
#' \item cospecies_native_n (numeric)
#' \item cospecies_mean_c (numeric)
#' \item cospecies_native_mean_c  (numeric)
#' \item cospecies_std_dev_c  (numeric)
#' \item cospecies_native_std_dev_c  (numeric)
#' \item percent_native  (numeric)
#' \item percent_nonnative (numeric)
#' \item percent_native_low_c (numeric)
#' \item percent_native_med_c  (numeric)
#' \item percent_native_high_c  (numeric)
#' \item discrepancy_c (numeric)
#' }
#'
#' @import dplyr
#' @importFrom rlang .data
#' @importFrom stats sd
#'
#'
#' @examples
#' # assessment_cooccurrences_summary is best used in combination with
#' # download_assessment_list() and assessment_list_inventory().
#'
#' \donttest{
#' maine <- download_assessment_list(database = 56)
#' maine_invs <- assessment_list_inventory(maine)
#' maine_cooccurrences_summary <- assessment_cooccurrences_summary(maine_invs)
#' }
#'
#' @export


assessment_cooccurrences_summary <- function(inventory_list) {

  bad_df <- data.frame(
    target_species = character (0),
    target_species_c = numeric(0),
    target_species_nativity = character(0),
    target_species_n = numeric(0),
    cospecies_n = numeric(0),
    cospecies_native_n = numeric(0),
    cospecies_mean_c = numeric(0),
    cospecies_native_mean_c = numeric(0),
    cospecies_std_dev_c = numeric(0),
    cospecies_native_std_dev_c = numeric(0),
    percent_native = numeric(0),
    percent_nonnative = numeric(0),
    percent_native_low_c = numeric(0),
    percent_native_med_c = numeric(0),
    percent_native_high_c = numeric(0),
    discrepancy_c = numeric(0)
  )

  if (!is_inventory_list(inventory_list)) {
    message(
      "assessment_list must be a list of inventories obtained from universalFQA.org. Type ?assessment_inventory_list for help."
    )
    return(invisible(bad_df))
  }

  cooccur <- assessment_cooccurrences(inventory_list)
  cooccur |> dplyr::group_by(.data$target_species,
                             .data$target_species_c,
                             .data$target_species_nativity) |>
    dplyr::summarize(
      target_species_c = unique(.data$target_species_c),
      target_species_nativity = unique(.data$target_species_nativity),
      target_species_n = unique(.data$target_species_n),
      cospecies_n = n(),
      cospecies_native_n =  sum(.data$cospecies_nativity == "native") ,
      cospecies_mean_c = mean(.data$cospecies_c,
                              na.rm = TRUE),
      cospecies_native_mean_c = mean(.data$cospecies_c[.data$cospecies_nativity == "native"],
                                     na.rm = TRUE),
      cospecies_std_dev_c = stats::sd(.data$cospecies_c,
                                      na.rm = TRUE),
      cospecies_native_std_dev_c = stats::sd(.data$cospecies_c[.data$cospecies_nativity == "native"],
                                             na.rm = TRUE),
      percent_native = .data$cospecies_native_n / .data$cospecies_n,
      percent_nonnative = 1 - .data$percent_native,
      percent_native_low_c = mean(.data$cospecies_c <= 3,
                                  na.rm = TRUE),
      percent_native_med_c = mean(.data$cospecies_c <= 7,
                                  na.rm = TRUE) - mean(.data$cospecies_c <= 3,
                                                       na.rm = TRUE),
      percent_native_high_c = 1 - mean(.data$cospecies_c <= 7,
                                       na.rm = TRUE),
      discrepancy_c = .data$target_species_c - .data$cospecies_native_mean_c
    ) |>
    ungroup() |>
    dplyr::arrange(.data$target_species)
}
