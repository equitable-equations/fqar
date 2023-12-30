#' Obtain tidy summary information for multiple floristic quality assessments
#'
#' \code{assessment_list_glance()} tidies a list of floristic quality assessment
#' data sets obtained from \href{https://universalfqa.org/}{universalfqa.org},
#' returning summary information as a single data frame.
#'
#' @param assessment_list A list of data sets downloaded from
#'   \href{https://universalfqa.org/}{universalfqa.org}, typically using
#'   \code{\link[=download_assessment_list]{download_assessment_list()}}.
#'
#' @return A data frame with 52 columns:
#' \itemize{
#'    \item title (character)
#'    \item date (date)
#'    \item site_name (character)
#'    \item city (character)
#'    \item county (character)
#'    \item state (character)
#'    \item country (character)
#'    \item fqa_db_region (character)
#'    \item fqa_db_publication_year (character)
#'    \item fqa_db_description (character)
#'    \item custom_fqa_db_name (character)
#'    \item custom_fqa_db_description (character)
#'    \item practitioner (character)
#'    \item latitude (character)
#'    \item longitude (character)
#'    \item weather_notes (character)
#'    \item duration_notes (character)
#'    \item community_type_notes (character)
#'    \item other_notes (character)
#'    \item private_public (character)
#'    \item total_mean_c (numeric)
#'    \item native_mean_c (numeric)
#'    \item total_fqi (numeric)
#'    \item native_fqi (numeric)
#'    \item adjusted_fqi (numeric)
#'    \item c_value_zero (numeric) Percent of c-values 0
#'    \item c_value_low (numeric) Percent of c-values 1-3
#'    \item c_value_mid (numeric) Percent of c-values 4-6
#'    \item c_value_high (numeric) Percent of c-values 7-10
#'    \item native_tree_mean_c (numeric)
#'    \item native_shrub_mean_c (numeric)
#'    \item native_herbaceous_mean_c (numeric)
#'    \item total_species (numeric)
#'    \item native_species (numeric)
#'    \item non_native_species
#'    \item mean_wetness (numeric)
#'    \item native_mean_wetness (numeric)
#'    \item tree (numeric)
#'    \item shrub (numeric)
#'    \item vine (numeric)
#'    \item forb (numeric)
#'    \item grass (numeric)
#'    \item sedge (numeric)
#'    \item rush (numeric)
#'    \item fern (numeric)
#'    \item bryophyte (numeric)
#'    \item annual (numeric)
#'    \item perennial (numeric)
#'    \item biennial (numeric)
#'    \item native_annual (numeric)
#'    \item native_perennial (numeric)
#'    \item native_biennial (numeric)
#' }
#'
#' @examples
#' # While assessment_list_glance can be used with a list of .csv file downloaded
#' # manually from the universal FQA website, it is most typically used
#' # in combination with download_assessment_list().
#'
#' maine <- download_assessment_list(database = 56)
#' assessment_list_glance(maine)
#'
#' @export


assessment_list_glance <- function(assessment_list) {

  df_bad <- data.frame(title = character(0),
                       date = numeric(0),
                       site_name = character(0),
                       city = character(0),
                       county = character(0),
                       state = character(0),
                       country = character(0),
                       fqa_db_region = character(0),
                       fqa_db_publication_year = character(0),
                       fqa_db_description = character(0),
                       custom_fqa_db_name = character(0),
                       custom_fqa_db_description = character(0),
                       practitioner = character(0),
                       latitude = character(0),
                       longitude = character(0),
                       weather_notes = character(0),
                       duration_notes = character(0),
                       community_type_notes = character(0),
                       other_notes = character(0),
                       private_public = character(0),
                       total_mean_c = numeric(0),
                       native_mean_c = numeric(0),
                       total_fqi = numeric(0),
                       native_fqi = numeric(0),
                       adjusted_fqi = numeric(0),
                       c_value_zero = numeric(0),
                       c_value_low = numeric(0),
                       c_value_mid = numeric(0),
                       c_value_high = numeric(0),
                       native_tree_mean_c = numeric(0),
                       native_shrub_mean_c = numeric(0),
                       native_herbaceous_mean_c = numeric(0),
                       total_species = numeric(0),
                       native_species = numeric(0),
                       non_native_species = numeric(0),
                       mean_wetness = numeric(0),
                       native_mean_wetness = numeric(0),
                       tree = numeric(0),
                       shrub = numeric(0),
                       vine = numeric(0),
                       forb = numeric(0),
                       grass = numeric(0),
                       sedge = numeric(0),
                       rush = numeric(0),
                       fern = numeric(0),
                       bryophyte = numeric(0),
                       annual = numeric(0),
                       perennial = numeric(0),
                       biennial = numeric(0),
                       native_annual = numeric(0),
                       native_perennial = numeric(0),
                       native_biennial = numeric(0)
  )

  df_bad$date <- as.Date(df_bad$date)

  if (!is_assessment_list(assessment_list)) {
    message(
      "assessment_list must be a list of dataframes obtained from universalFQA.org. Type ?download_assessment_list for help."
    )
    return(invisible(df_bad))
  }

  applied <- lapply(assessment_list,
                    assessment_glance)

  do.call(rbind, applied)

}


