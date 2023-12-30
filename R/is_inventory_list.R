#' Check if an object might be an inventory list.
#'
#' @param possible_list An object to be checked,
#'
#' @return A logical. TRUE if possible_list could be a list of inventories from
#'   universalfqa.org (for instance from assessment_list_inventory) and FALSE if
#'   it's definitely not.
#'
#' @noRd

is_inventory_list <- function(possible_inventory) {

  return <- FALSE

  tryCatch({

    if (is.list(possible_inventory) & (length(possible_inventory) != 0)) {
      outcomes <- lapply(possible_inventory,
                         is_inventory) |>
        as.logical()
      return <- all(outcomes)
    } else {
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
