#' Check if an object might be a transect list.
#'
#' @param possible_list An object to be checked
#'
#' @return A logical. TRUE if possible_list could be a list of assessments from
#'   universalfqa.org and FALSE if it's definitely not
#'
#' @noRd


is_transect_list <- function(possible_list) {

  return <- FALSE

  tryCatch({

    if (is.list(eval(possible_list)) & (length(possible_list) != 0)) {
      outcomes <- lapply(possible_list,
                         is_transect) |>
        as.logical()
      return <- all(outcomes) & (sum(outcomes) >= 1)
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

