#' Glance multiple FQA Transects in one Data Frame
#'
#' @param list a list of downloaded transects that were downloaded with download_transect_list().
#' @return A data frame with 53 columns:
#' \itemize{
#'    \item Title (character)
#'    \item Date (POSIXct)
#'    \item Site Name (character)
#'    \item City (character)
#'    \item County (character)
#'    \item State (character)
#'    \item Country (character)
#'    \item FQA DB Region (character)
#'    \item FQA DB Publication Year (character)
#'    \item FQA DB Description (character)
#'    \item FQA DB Selection Name (character)
#'    \item Practitioner (character)
#'    \item Latitude (character)
#'    \item Longitude (character)
#'    \item Community Code (character)
#'    \item Community Name (character)
#'    \item Community Type Notes (character)
#'    \item Weather Notes (character)
#'    \item Duration Notes (character)
#'    \item Environment Description (character)
#'    \item Other Notes (character)
#'    \item Transect/Plot Type (character)
#'    \item Plot Size (m2) (numeric)
#'    \item Quadrat/Subplot Size (m2) (numeric)
#'    \item Transect Length (m) (numeric)
#'    \item Sampling Design Description (character)
#'    \item Cover Method (character)
#'    \item Private/Public (character)
#'    \item Total Mean C (numeric)
#'    \item Cover-weighted Mean C (numeric)
#'    \item Native Mean C (numeric)
#'    \item Total FQI (numeric)
#'    \item Native FQI (numeric)
#'    \item Cover-weighted FQI (numeric)
#'    \item Cover-weighted Native FQI (numeric)
#'    \item Adjusted FQI (numeric)
#'    \item % C value 0 (numeric)
#'    \item % C value 1-3 (numeric)
#'    \item % C value 4-6 (numeric)
#'    \item % C value 7-10 (numeric)
#'    \item Species Richness (numeric)
#'    \item Total Species (numeric)
#'    \item Native Species (numeric)
#'    \item Non-native Species (numeric)
#'    \item Species Wetness (numeric)
#'    \item Mean Wetness (numeric)
#'    \item Native Mean Wetness (numeric)
#'    \item Annual (numeric)
#'    \item Perennial (numeric)
#'    \item Biennial (numeric)
#'    \item Native Annual (numeric)
#'    \item Native Perennial (numeric)
#'    \item Native Biennial (numeric)
#' }
#'
#' @import dplyr tidyr
#' @examples \dontrun{
#' ## transect_list_glance can be used with the download_transect_list() function:
#'
#' transect_list_glance(download_transect_list(149, id %in% test_vector))
#' # 149 is the database ID, see help file of download_assessment_list() for more information
#'
#' ## transect_glance_list can also be used with saved data from the download function:
#'
#' list <- (download_transect_list(149, id %in% test_vector)
#' transect_list_glance(list)
#' }
#' @export

transect_list_glance <- function(list){

  applied <- lapply(list, transect_glance)

  bind <- do.call(rbind, applied)

}

