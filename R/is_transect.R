#' Check if an object might be a transect data set
#'
#' @param possible_transect An object to be checked
#'
#' @return A logical. TRUE if possible_transect could be a transect assessments from
#'   universalfqa.org and FALSE if it's definitely not
#'
#' @noRd

is_transect <- function(possible_transect) {

  return <- TRUE

  tryCatch({

    if (!is.data.frame(possible_transect)) {
      return <- FALSE
    }

    if (ncol(possible_transect) == 1) {

      new <- rbind(names(possible_transect), possible_transect)

      possible_transect <- separate(
        new,
        col = 1,
        sep = ",",
        into = paste0("V", 1:14),
        fill = "right",
        extra = "merge"
      )

    } # for manually-downloaded sets


    names <- c("V1", "V2", "V3", "V4", "V5", "V6", "V7",
               "V8", "V9", "V10", "V11", "V12", "V13", "V14")

    if (!identical(colnames(possible_transect), names)){
      return <- FALSE
    }

    if (!identical(colnames(possible_transect), names)) {
      return <- FALSE
    }

  },
  error = function(e) {
    return <- FALSE
  },
  warning = function(w){
    return <- FALSE
  })

  return

}
