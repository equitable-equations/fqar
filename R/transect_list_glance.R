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
#' @return A data frame with 54 columns:
#' \itemize{
#'    \item Title (character)
#'    \item Date (date)
#'    \item Site Name (character)
#'    \item City (character)
#'    \item County (character)
#'    \item State (character)
#'    \item Country (character)
#'    \item Omernik Level 3 Ecoregion (character)
#'    \item FQA DB Region (character)
#'    \item FQA DB Publication Year (character)
#'    \item FQA DB Description (character)
#'    \item FQA DB Selection Name (character)
#'    \item Custom FQA DB Name (character)
#'    \item Custom FQA DB Description (character)
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
#'    \item \% C value 0 (numeric)
#'    \item \% C value 1-3 (numeric)
#'    \item \% C value 4-6 (numeric)
#'    \item \% C value 7-10 (numeric)
#'    \item Total Species (numeric)
#'    \item Native Species (numeric)
#'    \item Non-native Species (numeric)
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

transect_list_glance <- function(transect_list){

  applied <- lapply(transect_list, transect_glance)

  do.call(rbind, applied)

}

