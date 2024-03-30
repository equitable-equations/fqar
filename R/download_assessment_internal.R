#' Download specified FQA assessment with possible null result cached
#'
#' @param assessment_id A numeric identifier of the desired floristic quality
#'   assessment
#'
#' @return An untidy data frame in the original format of the Universal FQA
#'   website.
#'
#' @import httr jsonlite
#' @importFrom memoise memoise
#'
#' @noRd


download_assessment_internal <- memoise::memoise(function(assessment_id) {

  if (!is.numeric(assessment_id)) {
    stop("assessment_id must be an integer.", call. = FALSE)
  }
  if (assessment_id %% 1 != 0) {
    stop("assessment_id must be an integer.", call. = FALSE)
  }

  empty <- data.frame(V1 = character(0),
                      V2 = character(0),
                      V3 = character(0),
                      V4 = character(0),
                      V5 = character(0),
                      V6 = character(0),
                      V7 = character(0),
                      V8 = character(0),
                      V9 = character(0))
  class(empty) <- c("tbl_df",
                    "tbl",
                    "data.frame")

  if (assessment_id == -40000){
    return(invisible(empty))
  } # for testing internet errors

  assessment_address <-
    paste0("http://universalfqa.org/get/inventory/",
           assessment_id)
  ua <-
    httr::user_agent("https://github.com/equitable-equations/fqar")

  assessment_get <- tryCatch(httr::GET(assessment_address,
                                       ua,
                                       timeout(2)),
                             error = function(e){
                               message("No response from universalFQA.org. Please check internet connection.")
                               character(0)},
                             message = function(m){
                               message("No response from universalFQA.org. Please check internet connection.")
                               character(0)
                               }
  )

  cl <- class(assessment_get)
  if (cl != "response"){
    return(invisible(empty))
  }

  if (httr::http_error(assessment_get)) {
    message(
      paste(
        "API request to universalFQA.org failed. Error",
        httr::status_code(assessment_get)
      )
    )
    return(invisible(empty))
  }

  assessment_text <- httr::content(assessment_get,
                                   "text",
                                   encoding = "ISO-8859-1")
  assessment_json <- jsonlite::fromJSON(assessment_text)
  list_data <- assessment_json[[2]]

  if ((list_data[[1]] == "The requested assessment is not public") &
      (!is.na(list_data[[1]]))) {
    message("The requested assessment is not public.")
    return(invisible(empty))
  }

  max_length <-
    max(unlist(lapply(list_data, length))) # determines how wide the df must be
  list_data <- lapply(list_data,
                      function(x) {
                        length(x) <- max_length
                        unlist(x)
                      })

  out <- as.data.frame(do.call(rbind, list_data))

  class(out) <- c("tbl_df",
                  "tbl",
                  "data.frame")

  out

})
