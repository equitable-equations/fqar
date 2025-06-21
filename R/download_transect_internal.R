#' Download a single floristic quality transect assessment with possible null result cached
#'
#' @param transect_id A numeric identifier of the desired floristic quality
#'   transect assessment
#'
#' @return An untidy data frame in the original format of the Universal FQA
#'   website, except that the assessment id number has been appended in the
#'   first row.
#'
#' @import httr jsonlite
#' @importFrom memoise memoise
#'
#' @noRd


download_transect_internal <-
  memoise::memoise(function(transect_id,
                            timeout = 5) {

    if (!is.numeric(transect_id)) {
      stop("transect_id must be an integer.", call. = FALSE)
    }

    if (transect_id %% 1 != 0) {
      stop("transect_id must be an integer.", call. = FALSE)
    }

    if(!is.numeric(timeout)){
      stop("timeout must be an integer.",
           call. = FALSE)
    }

    empty <- data.frame(V1 = character(0),
                        V2 = character(0),
                        V3 = character(0),
                        V4 = character(0),
                        V5 = character(0),
                        V6 = character(0),
                        V7 = character(0),
                        V8 = character(0),
                        V9 = character(0),
                        V10 = character(0),
                        V11 = character(0),
                        V12 = character(0),
                        V13 = character(0),
                        V14 = character(0))
    class(empty) <- c("tbl_df",
                      "tbl",
                      "data.frame")

    if (transect_id == -40000) {
      return(invisible(empty))
    } # for testing internet errors

    trans_address <-
      paste0("http://universalfqa.org/get/transect/", transect_id)
    ua <-
      httr::user_agent("https://github.com/equitable-equations/fqar")

    trans_get <- tryCatch(httr::GET(trans_address,
                                    ua,
                                    httr::timeout(timeout)),
                          error = function(e){
                            message("No response from universalFQA.org. Please check internet connection.")
                            character(0)
                          }
    )

    cl <- class(trans_get)
    if (cl != "response"){
      return(invisible(empty))
    }

    if (httr::http_error(trans_get)) {
      message(
        paste(
          "API request to universalFQA.org failed. Error",
          httr::status_code(assessments_get)
        )
      )
      return(invisible(empty))
    }

    trans_text <- httr::content(trans_get,
                                "text",
                                encoding = "ISO-8859-1")
    trans_json <- jsonlite::fromJSON(trans_text)
    list_data <- trans_json[[2]]

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

    empty[1,1] <- as.character(transect_id)
    out <- rbind(empty, out)

    class(out) <- c("tbl_df",
                    "tbl",
                    "data.frame")

    out
  })
