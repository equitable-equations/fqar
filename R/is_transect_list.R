#' Check if an object might be a transect list.
#'
#' @param possible_list An object to be checked,
#'
#' @return A logical. TRUE if possible_list could be a list of assessments from
#'   universalfqa.org and FALSE if it's definitely not
#'
#' @noRd


is_transect_list <- function(possible_list) {
  return <- TRUE

  if (is.null(possible_list)) {
    return <- FALSE
  }

  tryCatch({
    if (length(possible_list) == 0) {
      return <- FALSE
    }

    if (!is.data.frame(possible_list[[1]])) {
      return <- FALSE
    }

    if (ncol(possible_list[[1]]) != 14) {
      return <- FALSE
    }

    if (colnames(possible_list[[1]][1]) != "V1") {
      return <- FALSE
    }

    if (!("Species Richness:" %in% possible_list[[1]]$V1)) {
      return <- FALSE
    }

  },
  error = function(e) {
    return <- FALSE
  })

  return
}
