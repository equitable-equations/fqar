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
#'
#' @return An untidy data frame in the original format of the Universal FQA
#'   website. Use \code{\link[=transect_glance]{transect_glance()}} for a tidy
#'   summary, \code{\link[=transect_phys]{transect_phys()}} for a physiognometric
#'   overview, and \code{\link[=transect_inventory]{transect_inventory()}} for
#'   species-level data.
#'
#' @importFrom memoise drop_cache
#'
#' @examples
#' \donttest{
#' databases <- index_fqa_databases() # Note database 1 is the original 1994 Chicago edition.
#' chicago_transects <- index_fqa_transects(1) # CBG Sand prairie swale fen A has id number 5932.
#' cbg <- download_transect(5932)
#' cbg_tidy <- transect_glance(cbg)
#' cbg_species <- transect_inventory(cbg)
#' cbg_phys <- transect_phys(cbg)
#' }
#'
#' @export


download_transect <- function(transect_id) {
  out <- download_transect_internal(transect_id)
  if (is.null(out)){
    memoise::drop_cache(download_transect_internal)({{ transect_id }})
  }
  out
}


