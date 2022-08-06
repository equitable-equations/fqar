#' Glance multiple FQA Assessments in one Data Frame
#'
#' @param list a list of downloaded assessments that were downloaded with download_assessment_list().
#' @return A data frame with 52 columns:
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
#'    \item % C value 0 (numeric)
#'    \item % C value 1-3 (numeric)
#'    \item % C value 4-6 (numeric)
#'    \item % C value 7-10 (numeric)
#'    \item Native Tree Mean C (numeric)
#'    \item Native Shrub Mean C (numeric)
#'    \item Native Herbaceous Mean C (numeric)
#'    \item Species Richness (numeric)
#'    \item Total Species (numeric)
#'    \item Native Species (numeric)
#'    \item Non-native Species (numeric)
#'    \item Species Wetness (numeric)
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
#' @examples
#' \dontrun{
#' ## assessment_list_glance can be used with the download_assessment_list() function:
#'
#' assessment_list_glance(download_assessment_list(149, id %in% test_vector))
#' # 149 is the database ID, see help file of download_assessment_list() for more information
#'
#' ## assessment_list_glance can also be used with saved data from the download function:
#'
#' list <- (download_assessment_list(149, id %in% test_vector)
#' assessment_list_glance(list)
#' }
#' @export
assessment_list_glance <- function(list){

  applied <- lapply(list, assessment_glance)

  bind <- do.call(rbind, applied)

  data <- bind |>
    mutate(across(.cols=19:52, .fns=as.numeric))

}


