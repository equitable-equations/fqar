#' Check if an object might be an fqa assessment data set
#'
#' @param possible_assessment An object to be checked
#'
#' @return A logical. TRUE if possible_assessment could be an fqa assessments from
#'   universalfqa.org and FALSE if it's definitely not
#'
#' @noRd

is_assessment <- function(possible_assessment) {

  return <- TRUE

  tryCatch({

    if (!is.data.frame(possible_assessment)) {
      return <- FALSE
    }

    if (ncol(possible_assessment) == 1) {

      new <- rbind(names(possible_assessment), possible_assessment)

      possible_assessment <- separate(
        new,
        col = 1,
        sep = ",",
        into = paste0("V", 1:9),
        fill = "right",
        extra = "merge"
      )

    } # for manually-downloaded sets

    names <- c("V1", "V2", "V3", "V4", "V5", "V6", "V7", "V8", "V9")

    if (!identical(colnames(possible_assessment), names)){
      return <- FALSE
    }

    if (!("Species Richness:" %in% possible_assessment$V1)) {
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
