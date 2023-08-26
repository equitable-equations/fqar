#' Download a single floristic quality transect assessment with possible null result cached
#'
#' @param transect_id A numeric identifier of the desired floristic quality
#'   transect assessment
#'
#' @return An untidy data frame in the original format of the Universal FQA
#'   website.
#'
#' @import httr jsonlite
#' @importFrom memoise memoise
#'
#' @noRd

download_transect_internal <- memoise::memoise(function(transect_id) {
  if (!is.numeric(transect_id)) {
    stop("transect_id must be an integer.", call. = FALSE)
  }
  if (transect_id %% 1 != 0) {
    stop("transect_id must be an integer.", call. = FALSE)
  }
  if (transect_id == -40000) {
    return(invisible(NULL))
  } # for testing memoisation

  trans_address <-
    paste0("http://universalfqa.org/get/transect/", transect_id)
  ua <-
    httr::user_agent("https://github.com/equitable-equations/fqar")

  trans_get <- tryCatch(httr::GET(trans_address, ua),
                        error = function(e){
                          message("Unable to connect. Please check internet connection.")
                          character(0)
                        }
  )

  cl <- class(trans_get)
  if (cl != "response"){
    return(invisible(NULL))
  }

  if (httr::http_error(trans_get)) {
    message(
      paste(
        "API request to universalFQA.org failed. Error",
        httr::status_code(assessments_get)
      )
    )
    return(invisible(NULL))
  }

  trans_text <- httr::content(trans_get,
                              "text",
                              encoding = "ISO-8859-1")
  trans_json <- jsonlite::fromJSON(trans_text)
  list_data <- trans_json[[2]]

  if ((list_data[[1]] == "The requested assessment is not public") &
      (!is.na(list_data[[1]]))) {
    message("The requested assessment is not public. Returning NULL.")
    return(invisible(NULL))
  }

  max_length <-
    max(unlist(lapply(list_data, length))) # determines how wide the df must be
  list_data <- lapply(list_data,
                      function(x) {
                        length(x) <- max_length
                        unlist(x)
                      })

  as.data.frame(do.call(rbind, list_data))

})
