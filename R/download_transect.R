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

download_transect <- function(transect_id){

  if (!is.numeric(transect_id)) {
    stop("transect_id must be an integer.", call. = FALSE)
    }
  if (transect_id %% 1 != 0) {
    stop("transect_id must be an integer.", call. = FALSE)
    }

  trans_address <- paste0("http://universalfqa.org/get/transect/", transect_id)
  ua <- httr::user_agent("https://github.com/equitable-equations/fqar")

  trans_get <- httr::GET(trans_address, ua)
  if (httr::http_error(trans_get)) {
    stop(paste("API request to universalFQA.org failed. Error",
               httr::status_code(trans_get)),
         call. = FALSE
    )
  }

  trans_text <- httr::content(trans_get,
                              "text",
                              encoding = "ISO-8859-1")
  trans_json <- jsonlite::fromJSON(trans_text)
  list_data <- trans_json[[2]]

  if ((list_data[[1]] == "The requested assessment is not public") & (!is.na(list_data[[1]]))) {
    stop("The requested assessment is not public", call. = FALSE)
  }

  max_length <- max(unlist(lapply(list_data, length))) # determines how wide the df must be
  list_data <- lapply(list_data,
                      function(x) {
                        length(x) <- max_length
                        unlist(x)
                        }
                      )

  as.data.frame(do.call(rbind, list_data))
  }

