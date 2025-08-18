#' Obtain species details for a list of floristic quality assessments
#'
#' \code{assessment_list_inventory()} returns a list of data frames, each of
#' which consists of all plant species included in a floristic quality
#' assessment obtained from \href{https://universalfqa.org/}{universalfqa.org}.
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
#' # While assessment_list_inventory can be used with a list of .csv file downloaded
#' # manually from the universal FQA website, it is most typically used
#' # in combination with download_assessment_list().
#'
#' \donttest{
#' maine <- download_assessment_list(database = 56)
#' maine_invs <- assessment_list_inventory(maine)
#' }
#'
#' @export


assessment_list_inventory <- function(assessment_list) {

  bad_df <- data.frame(scientific_name = character(0),
                       family = character(0),
                       acronym = character(0),
                       nativity = character(0),
                       c = numeric(0),
                       w = numeric(0),
                       physiognomy = character(0),
                       duration = character(0),
                       common_name = character(0)
  )

  if (!is_assessment_list(assessment_list)) {
    message(
      "assessment_list must be a list of dataframes obtained from universalFQA.org. Type ?download_assessment_list for help."
    )
    return(invisible(bad_df))
  }

  applied <- suppressMessages(
    lapply(assessment_list,
           assessment_inventory))

  applied
}
