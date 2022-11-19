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
#'   website. Use \code{\link[=assessment_glance]{assessment_glance()}} for a
#'   tidy summary and
#'   \code{\link[=assessment_inventory]{assessment_inventory()}} for
#'   species-level data.
#'
#' @import jsonlite httr
#'
#' @examples
#' \donttest{
#' databases <- index_fqa_databases()
#' # Note database 1 is the original 1994 Chicago edition.
#'
#' chicago_assessments <- index_fqa_assessments(1) # Edison dune and swale has id number 25002.
#' edison <- download_assessment(25002)
#'
#' edison_tidy <- assessment_glance(edison)
#' edison_species <- assessment_inventory(edison)
#' }
#'
#' @export

download_assessment <- function(assessment_id){

  if (!is.numeric(assessment_id)) {
    stop("assessment_id must be an integer.", call. = FALSE)
    }
  if (assessment_id %% 1 != 0) {
    stop("assessment_id must be an integer.", call. = FALSE)
    }

  assessment_address <- paste0("http://universalfqa.org/get/inventory/",
                               assessment_id)
  ua <- httr::user_agent("https://github.com/equitable-equations/fqar")

  assessment_get <- httr::GET(assessment_address, ua)
  if (httr::http_error(assessment_get)) {
    stop(paste("API request to universalFQA.org failed. Error",
               httr::status_code(assessment_get)),
         call. = FALSE
    )
  }
  assessment_text <- httr::content(assessment_get,
                                   "text",
                                   encoding = "ISO-8859-1")
  assessment_json <- jsonlite::fromJSON(assessment_text)
  list_data <- assessment_json[[2]]

  if ((list_data[[1]] == "The requested assessment is not public") & (!is.na(list_data[[1]]))) {
    stop("The requested assessment is not public", call. = FALSE)
  }

  max_length <- max(unlist(lapply(list_data, length))) # determines how wide the df must be
  list_data <- lapply(list_data,
                      function(x) {
                        length(x) <- max_length
                        unlist(x)
  })

  as.data.frame(do.call(rbind, list_data))

}
