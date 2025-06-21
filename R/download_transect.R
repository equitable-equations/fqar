#' Download a single floristic quality transect assessment
#'
#' \code{download_transect()} retrieves a specified floristic quality transect
#' assessment from \href{https://universalfqa.org/}{universalfqa.org}. ID
#' numbers for transect assessments in various databases can be found using the
#' \code{\link[=index_fqa_transects]{index_fqa_transects()}} function.
#'
#' @param transect_id A numeric identifier of the desired floristic quality
#'   transect assessment, as specified by
#'   \href{https://universalfqa.org/}{universalfqa.org}. ID numbers for transect
#'   assessments in specified databases can be viewed with the
#'   \code{\link[=index_fqa_transects]{index_fqa_transects()}} function.
#' @param timeout Number of seconds to query UniversalFQA before timing out.
#'
#' @return An untidy data frame in the original format of the Universal FQA
#'   website, except that the transect id number has been appended in the
#'   first row.. Use \code{\link[=transect_glance]{transect_glance()}} for a tidy
#'   summary, \code{\link[=transect_phys]{transect_phys()}} for a
#'   physiognometric overview, and
#'   \code{\link[=transect_inventory]{transect_inventory()}} for species-level
#'   data.
#'
#' @importFrom memoise drop_cache
#'
#' @examples
#' \donttest{
#' databases <- index_fqa_databases() # Database 1 is the original 1994 Chicago edition.
#' chicago_transects <- index_fqa_transects(1) # CBG Sand prairie swale fen A has id number 5932.
#' cbg <- download_transect(5932, timeout = 10)
#' }
#'
#' @export


download_transect <- function(transect_id,
                              timeout = 4) {

  out <- download_transect_internal(transect_id,
                                    timeout)

  if (nrow(out) == 0){
    memoise::drop_cache(download_transect_internal)({{ transect_id }})
    return(invisible(out))
  }

  out
}


