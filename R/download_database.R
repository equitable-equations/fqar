#' Download a single floristic quality database
#'
#' \code{download_database()} retrieves a specified floristic quality database
#' from \href{https://universalfqa.org/}{universalfqa.org}. A list of available
#' databases can be found using the
#' \code{\link[=index_fqa_databases]{index_fqa_databases()} } function.
#'
#' @param database_id A numeric identifier of the desired floristic quality
#'   database, as specified by
#'   \href{https://universalfqa.org/}{universalfqa.org}. ID numbers for
#'   databases recognized this site can be viewed with the
#'   \code{\link[=index_fqa_databases]{index_fqa_databases()}} function.
#'
#' @return An untidy data frame in the original format of the Universal FQA
#'   website. Use \code{\link[=database_glance]{database_glance()}} for a tidy
#'   summary and \code{\link[=database_inventory]{database_inventory()}} for
#'   species-level data.
#'
#' @importFrom memoise drop_cache
#'
#' @examples
#' \donttest{
#' databases <- index_fqa_databases()
#' # Note database 1 is the original 1994 Chicago edition.
#'
#' chicago_database <- download_database(1)
#' }
#'
#' @export


download_database <- function(database_id) {

  out <- download_database_internal(database_id)

  if (nrow(out) == 0 | out$V2[5] == 0){
    memoise::drop_cache(download_database_internal)({{ database_id }})
    return(invisible(out))
  }

  out
}





