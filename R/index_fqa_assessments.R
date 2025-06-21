#' List all available public floristic quality assessments
#'
#' For any given database, \code{index_fqa_assessments()} produces a data frame
#' of all floristic quality assessments publicly available at
#' \href{https://universalfqa.org/}{universalfqa.org}.
#'
#' @param database_id A numeric identifier of the desired database, as specified
#'   by \href{https://universalfqa.org/}{universalfqa.org}. The id numbers can
#'   be viewed with the
#'   \code{\link[=index_fqa_databases]{index_fqa_databases()}} function.
#' @param timeout Number of seconds to query UniversalFQA before timing out.
#'
#' @return A data frame with 5 columns:
#' \itemize{
#'   \item id (numeric)
#'   \item assessment (character)
#'   \item date (date)
#'   \item site (character)
#'   \item practitioner (character)
#'   }
#'
#' @importFrom memoise drop_cache
#'
#' @examples
#' \donttest{
#' databases <- index_fqa_databases() # The 2017 Chicago database has id_number 149
#' chicago_2017_assessments <- index_fqa_assessments(149)
#' }
#'
#' @export


index_fqa_assessments <- function(database_id,
                                  timeout = 5) {

  out <- index_fqa_assessments_internal(database_id,
                                        timeout)

  if (nrow(out) == 0){
    memoise::drop_cache(index_fqa_assessments_internal)({{ database_id }})
    return(invisible(out))
  }

  out
}





