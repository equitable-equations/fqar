#' List all available floristic quality assessment databases
#'
#' \code{index_fqa_databases()} produces a data frame showing all floristic
#' quality assessment databases publicly available at
#' \href{https://universalfqa.org/}{universalfqa.org}.
#'
#' @param timeout Number of seconds to query UniversalFQA before timing out.
#'
#' @return A data frame with 4 columns:
#' \itemize{
#'   \item database_id (numeric)
#'   \item region (character)
#'   \item year (numeric)
#'   \item description (character)
#' }
#'
#' @importFrom memoise forget
#'
#' @examples
#' databases <- index_fqa_databases()
#'
#' @export


index_fqa_databases <- function(timeout = 4) {

  out <- index_fqa_databases_internal(timeout)

  if (nrow(out) == 0){
    memoise::forget(index_fqa_databases_internal)
    return(invisible(out))
  }

  out

}



