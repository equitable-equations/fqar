#' Check if an object might be an assessment list.
#'
#' @param possible_list An object to be checked,
#'
#' @return A logical. TRUE if possible_list could be a list of assessments from
#'   universalfqa.org and FALSE if it's definitely not.
#'
#' @noRd


is_assessment_list <- function(possible_list) {

  return <- TRUE

  tryCatch({

    if (!is.list(possible_list) | (length(possible_list) == 0)) {
      return <- FALSE
    } else {
      outcomes <- lapply(possible_list,
                         is_assessment) |>
        as.logical()
      return <- all(outcomes)
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

