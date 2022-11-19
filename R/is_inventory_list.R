#' Check is an object might be an inventory list. NOT fullproof.
#'
#' @param possible_list An object to be checked,
#'
#' @return A logical. TRUE if possible_list could be a list of inventories from
#'   universalfqa.org (for instance from assessment_list_inventory)and FALSE if
#'   it's definitely not.
#'
#' @noRd


is_inventory_list <- function(possible_list){

  return <- TRUE

  if (is.null(possible_list)){
    return <- FALSE
  }

  tryCatch({

    if (!is.list(possible_list)){
      return <- FALSE
    }

    if (length(possible_list) == 0){
      return <- FALSE
    }

    if (!is.data.frame(possible_list[[1]])){
      return <- FALSE
    }

    if (ncol(possible_list[[1]]) != 9){
      return <- FALSE
    }

    if (colnames(possible_list[[1]])[1] != "scientific_name" |
        colnames(possible_list[[1]])[2] != "family" |
        colnames(possible_list[[1]])[3] != "acronym" |
        colnames(possible_list[[1]])[4] != "nativity" |
        colnames(possible_list[[1]])[5] != "c" |
        colnames(possible_list[[1]])[6] != "w" |
        colnames(possible_list[[1]])[7] != "physiognomy" |
        colnames(possible_list[[1]])[8] != "duration" |
        colnames(possible_list[[1]])[9] != "common_name"
        ){
      return <- FALSE
    }

  },
  error = function(e){
    return <- FALSE
  })

  return
}
