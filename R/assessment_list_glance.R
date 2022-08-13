#' Obtain tidy summary information for multiple floristic quality assessments
#'
#' \code{assessment_list_glance()} tidies a list of floristic quality assessment
#' data sets obtained from \href{https://universalfqa.org/}{universalfqa.org},
#' returning summary information as a single data frame.
#'
#' @param assessment_list A list of data sets downloaded from
#'   \href{https://universalfqa.org/}{universalfqa.org}, typically using
#'   \code{\link{download_assessment_list}}.
#'
#' @return A data frame with 52 columns:
#' \itemize{
#'    \item Title (character)
#'    \item Date (date)
#'    \item Site Name (character)
#'    \item City (character)
#'    \item County (character)
#'    \item State (character)
#'    \item Country (character)
#'    \item FQA DB Region (character)
#'    \item FQA DB Publication Year (character)
#'    \item FQA DB Description (character)
#'    \item Custom FQA DB Name (character)
#'    \item Custom FQA DB Description (character)
#'    \item Practitioner (character)
#'    \item Latitude (character)
#'    \item Longitude (character)
#'    \item Weather Notes (character)
#'    \item Duration Notes (character)
#'    \item Community Type Notes (character)
#'    \item Other Notes (character)
#'    \item Private/Public (character)
#'    \item Total Mean C (numeric)
#'    \item Native Mean C (numeric)
#'    \item Total FQI: (numeric)
#'    \item Native FQI (numeric)
#'    \item Adjusted FQI (numeric)
#'    \item \% C value 0 (numeric)
#'    \item \% C value 1-3 (numeric)
#'    \item \% C value 4-6 (numeric)
#'    \item \% C value 7-10 (numeric)
#'    \item Native Tree Mean C (numeric)
#'    \item Native Shrub Mean C (numeric)
#'    \item Native Herbaceous Mean C (numeric)
#'    \item Total Species (numeric)
#'    \item Native Species (numeric)
#'    \item Non-native Species
#'    \item Mean Wetness (numeric)
#'    \item Native Mean Wetness (numeric)
#'    \item Tree (numeric)
#'    \item Shrub (numeric)
#'    \item Vine (numeric)
#'    \item Forb (numeric)
#'    \item Grass (numeric)
#'    \item Sedge (numeric)
#'    \item Rush (numeric)
#'    \item Fern (numeric)
#'    \item Bryophyte (numeric)
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
#' # While assessment_list_glance can be used with .csv files downloaded
#' # manually from the universal FQA website, it is most typically used
#' # in combination with download_assessment_list().
#'
#' missouri <- download_assessment_list(database = 63)
#' assessment_list_glance(missouri)
#' }
#'
#' @export
assessment_list_glance <- function(assessment_list){

  applied <- lapply(assessment_list, assessment_glance)

  do.call(rbind, applied)

}


