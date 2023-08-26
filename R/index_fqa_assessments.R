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
#' databases <- index_fqa_databases()
#' # Note that the 2017 Chicago database has id_number 149
#' chicago_2017_assessments <- index_fqa_assessments(149)
#' }
#'
#' @export


index_fqa_assessments <- function(database_id) {
  out <- tryCatch(index_fqa_assessments_internal(database_id),
                  warning = function(w) {
                    warning(w)
                    memoise::drop_cache(index_fqa_assessments_internal)({{ database_id }})
                    return(invisible(NULL))
                  },
                  message = function(m) {
                    message(m)
                    memoise::drop_cache(index_fqa_assessments_internal)({{ database_id }})
                    return(invisible(NULL))
                  }
  )

  if (is.null(out)){
    memoise::drop_cache(index_fqa_assessments_internal)({{ database_id }})
  }

  out

}




