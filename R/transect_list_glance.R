#' Obtain tidy summary information for multiple floristic quality transect
#' assessments
#'
#' \code{transect_list_glance()} tidies a list of floristic quality transect
#' assessment data sets obtained from
#' \href{https://universalfqa.org/}{universalfqa.org}, returning summary
#' information as a single data frame.
#'
#' @param transect_list A list of data sets downloaded from
#'   \href{https://universalfqa.org/}{universalfqa.org}, typically using
#'   \code{\link[=download_transect_list]{download_transect_list()}}.
#'
#' @return A data frame with 1 row and 55 columns:
#' \itemize{
#'    \item transect_id (numeric)
#'    \item title (character)
#'    \item date (date)
#'    \item site_name (character)
#'    \item city (character)
#'    \item county (character)
#'    \item state (character)
#'    \item country (character)
#'    \item omernik_level_three_ecoregion (character)
#'    \item fqa_db_region (character)
#'    \item fqa_db_publication_year (character)
#'    \item fqa_db_description (character)
#'    \item fqa_db_selection_name (character)
#'    \item custom_fqa_db_name (character)
#'    \item custom_fqa_db_description (character)
#'    \item practitioner (character)
#'    \item latitude (character)
#'    \item longitude (character)
#'    \item community_code (character)
#'    \item community_name (character)
#'    \item community_type_notes (character)
#'    \item weather_notes (character)
#'    \item duration_notes (character)
#'    \item environment_description (character)
#'    \item other_notes (character)
#'    \item transect_plot_type (character)
#'    \item plot_size (numeric) Plot size in square meters
#'    \item quadrat_subplot_size (numeric) Quadrat or subplot size in square meters
#'    \item transect_length (numeric) Transect length in meters
#'    \item sampling_design_description (character)
#'    \item cover_method (character)
#'    \item private_public (character)
#'    \item total_mean_c (numeric)
#'    \item cover_weighted_mean_c (numeric)
#'    \item native_mean_c (numeric)
#'    \item total_fqi (numeric)
#'    \item native_fqi (numeric)
#'    \item cover_weighted_fqi (numeric)
#'    \item cover_weighted_native_fqi (numeric)
#'    \item adjusted_fqi (numeric)
#'    \item c_value_zero (numeric) Percent of c-values 0
#'    \item c_value_low (numeric) Percent of c-values 1-3
#'    \item c_value_mid (numeric) Percent of c-values 4-6
#'    \item c_value_high (numeric) Percent of c-values 7-10
#'    \item total_species (numeric)
#'    \item native_species (numeric)
#'    \item non_native_species (numeric)
#'    \item mean_wetness (numeric)
#'    \item native_mean_wetness (numeric)
#'    \item annual (numeric)
#'    \item perennial (numeric)
#'    \item biennial (numeric)
#'    \item native_annual (numeric)
#'    \item native_perennial (numeric)
#'    \item native_biennial (numeric)
#' }
#'
#' @import dplyr tidyr
#' @examples
#' # While transect_list_glance can be used with a list of .csv file downloaded
#' # manually from the universal FQA website, it is most typically used in
#' # combination with download_transect_list().
#'
#' \donttest{
#' transect_list <- download_transect_list(149, id %in% c(3400, 3427))
#' transect_list_glance(transect_list)
#' }
#'
#' @export


transect_list_glance <- function(transect_list) {

  bad_df <- data.frame(
    transect_id = numeric(0),
    title = character(0),
    date = numeric(0),
    site_name = character(0),
    city = character(0),
    county = character(0),
    state = character(0),
    country = character(0),
    omernik_level_three_ecoregion = character(0),
    fqa_db_region = character(0),
    fqa_db_publication_year = character(0),
    fqa_db_description = character(0),
    fqa_db_selection_name = character(0),
    custom_fqa_db_name = character(0),
    custom_fqa_db_description = character(0),
    practitioner = character(0),
    latitude = character(0),
    longitude = character(0),
    community_code = character(0),
    community_name = character(0),
    community_type_notes = character(0),
    weather_notes = character(0),
    duration_notes = character(0),
    environment_description = character(0),
    other_notes = character(0),
    transect_plot_type = character(0),
    plot_size = numeric(0),
    quadrat_subplot_size = numeric(0),
    transect_length = numeric(0),
    sampling_design_description = character(0),
    cover_method = character(0),
    private_public = character(0),
    total_mean_c = numeric(0),
    cover_weighted_mean_c = numeric(0),
    native_mean_c = numeric(0),
    total_fqi = numeric(0),
    native_fqi = numeric(0),
    cover_weighted_fqi = numeric(0),
    cover_weighted_native_fqi = numeric(0),
    adjusted_fqi = numeric(0),
    c_value_zero = numeric(0),
    c_value_low = numeric(0),
    c_value_mid = numeric(0),
    c_value_high = numeric(0),
    total_species = numeric(0),
    native_species = numeric(0),
    non_native_species = numeric(0),
    mean_wetness = numeric(0),
    native_mean_wetness = numeric(0),
    annual = numeric(0),
    perennial = numeric(0),
    biennial = numeric(0),
    native_annual = numeric(0),
    native_perennial = numeric(0),
    native_biennial = numeric(0)
  )

  bad_df$date <- as.Date(bad_df$date)

  if (!is_transect_list(transect_list)) {
    message(
      "transect_list must be a list of dataframes obtained from universalFQA.org. Type ?download_transect_list for help."
    )
    return(invisible(bad_df))
  }

  applied <- lapply(transect_list, transect_glance)

  do.call(rbind, applied)

}

