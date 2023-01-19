#' Obtain species details for a list of floristic quality assessments
#'
#' \code{assessment_list_inventory()} returns a list of data frames, each of which
#' consists of all plant species included in a floristic quality assessment
#' obtained from \href{https://universalfqa.org/}{universalfqa.org}.
#'
#' @param assessment_list  A list of data sets downloaded from
#'   \href{https://universalfqa.org/}{universalfqa.org}, typically using
#'   \code{\link[=download_assessment_list]{download_assessment_list()}}.
#'
#' @return A list of data frames, each with 9 columns:
#' \itemize{
#'    \item scientific_name (character)
#'    \item family (character)
#'    \item acronym (character)
#'    \item nativity (character)
#'    \item c (numeric)
#'    \item w (numeric)
#'    \item physiognomy (character)
#'    \item duration (character)
#'    \item common_name (character)
#' }
#'
#' @examples
#' \donttest{
#' # While assessment_list_inventory can be used with a list of .csv file downloaded
#' # manually from the universal FQA website, it is most typically used
#' # in combination with download_assessment_list().
#'
#' ontario <- download_assessment_list(database = 2)
#' ontario_invs <- assessment_list_inventory(ontario)
#' }
#'
#' @export


assessment_list_inventory <- function(assessment_list) {
  if (!is_assessment_list(assessment_list)) {
    stop(
      "assessment_list must be a list of dataframes obtained from universalFQA.org. Type ?download_assessment_list for help.",
      call. = FALSE
    )
  }

  applied <- lapply(assessment_list,
                    assessment_inventory)

  applied
}
