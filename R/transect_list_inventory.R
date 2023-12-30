#' Obtain species details for a list of transect assessments
#'
#' \code{transect_list_inventory()} returns a list of data frames, each of which
#' consists of all plant species included in a floristic quality assessment of a
#' transect obtained from \href{https://universalfqa.org/}{universalfqa.org}.
#'
#' @param transect_list  A list of data sets downloaded from
#'   \href{https://universalfqa.org/}{universalfqa.org}, typically using
#'   \code{\link[=download_transect_list]{download_transect_list()}}.
#'
#' @return A list of data frames, each with 13 columns:
#' \itemize{
#'    \item species (character)
#'    \item family (character)
#'    \item acronym (character)
#'    \item nativity (character)
#'    \item c (numeric)
#'    \item w (numeric)
#'    \item physiognomy (character)
#'    \item duration (character)
#'    \item frequency (numeric)
#'    \item coverage (numeric)
#'    \item relative_frequency_percent (numeric)
#'    \item relative_coverage_percent (numeric)
#'    \item relative_importance_value (numeric)
#' }
#'
#' @examples
#' \donttest{
#' # While transect_list_inventory can be used with a list of .csv file downloaded
#' # manually from the universal FQA website, it is most typically used
#' # in combination with download_transect_list()
#'
#' chicago <- download_transect_list(database = 149)
#' chicago_invs <- transect_list_inventory(chicago)
#' }
#'
#' @export


transect_list_inventory <- function(transect_list) {

  if (!is_transect_list(transect_list)) {
    message(
      "transect_list must be a list of dataframes obtained from universalFQA.org. Type ?download_transect_list for help."
    )
    return(invisible(list()))
  }

  applied <- lapply(transect_list,
                    transect_inventory)

  applied
}


