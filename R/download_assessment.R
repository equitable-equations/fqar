#' Download a single floristic quality assessment
#'
#' \code{download_assessment()} retrieves a specified floristic quality
#' assessment from \href{https://universalfqa.org/}{universalfqa.org}. ID
#' numbers for assessments in various databases can be found using the
#' \code{\link[=index_fqa_assessments]{index_fqa_assessments()}} function.
#'
#' @param assessment_id A numeric identifier of the desired floristic quality
#'   assessment, as specified by
#'   \href{https://universalfqa.org/}{universalfqa.org}. ID numbers for
#'   assessments in specified databases can be viewed with the
#'   \code{\link[=index_fqa_assessments]{index_fqa_assessments()}} function.
#'
#' @return An untidy data frame in the original format of the Universal FQA
#'   website, except that the assessment id number has been appended in the
#'   first row. Use \code{\link[=assessment_glance]{assessment_glance()}} for a
#'   tidy summary and
#'   \code{\link[=assessment_inventory]{assessment_inventory()}} for
#'   species-level data.
#'
#' @importFrom memoise drop_cache
#'
#' @examples
#'
#' \donttest{
#' databases <- index_fqa_databases() # Database 1 is the original 1994 Chicago edition.
#'
#' chicago_assessments <- index_fqa_assessments(1) # Edison dune and swale has id number 25002.
#' edison <- download_assessment(25002)
#'
#' edison_tidy <- assessment_glance(edison)
#' }
#'
#' @export


download_assessment <- function(assessment_id) {

  out <- download_assessment_internal(assessment_id)

  if (nrow(out) == 0){
    memoise::drop_cache(download_assessment_internal)({{ assessment_id }})
    return(invisible(out))
  }

  out
}

