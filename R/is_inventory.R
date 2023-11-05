#' Check if an object might be an inventory
#'
#' @param possible_inv An object to be checked,
#'
#' @return A logical. TRUE if possible_inv could be an inventory from
#'   universalfqa.org (for instance from assessment_list_inventory) and FALSE if
#'   it's definitely not.
#'
#' @noRd
#'

is_inventory <- function(possible_inv){

  return <- FALSE

  tryCatch({
    if (is.data.frame(possible_inv)) {
      return <- TRUE
    }},
    error = function(e) {
      return <- FALSE
    },
    warning = function(w){
      return <- FALSE
    })

  names <- c("scientific_name",
    "family",
    "acronym",
    "nativity",
    "c",
    "w",
    "physiognomy",
    "duration",
    "common_name"
  )

  tryCatch({

    if (!identical(colnames(possible_inv), names)){
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




