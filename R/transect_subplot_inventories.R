#' Extract quadrat/subplot-level inventories from a transect assessment
#'
#' \code{transect_subplot_inventories()} accepts a floristic quality transect
#' assessment data set obtained from
#' \href{https://universalfqa.org/}{universalfqa.org} and returns a list of
#' species inventories, one per quadrat/subplot.

#' @param transect A data set downloaded from
#'   \href{https://universalfqa.org/}{universalfqa.org} either manually or using
#'   \code{\link[=download_transect]{download_transect()}}.
#'
#' @return A list of data frames, each with 9 columns:
#' \itemize{
#'    \item scientific_name (character)
#'    \item family (character)
#'    \item acronym (character)
#'    \item nativity (character)
#'    \item c (numeric)
#'    \item w (numeric)
#'    \item physiognomy (character)
#'    \item duration (character)
#'    \item common_name (character)
#'    }
#'
#' @import dplyr
#' @importFrom rlang .data
#'
#' @examples
#' \donttest{
#'  cbg_fen <- download_transect(5932)
#'  cbg_inventories <- transect_subplot_inventories(cbg_fen)
#'  }
#'
#' @export

transect_subplot_inventories <- function(transect){

  if (!is.data.frame(transect)) {
    stop("data_set must be a dataframe obtained from the universalFQA.org website. Type ?download_transect for help.", call. = FALSE)
  }
  if (ncol(transect) == 0){
    stop("data_set must be a dataframe obtained from the universalFQA.org website. Type ?download_assessment for help.", call. = FALSE)
  }
  if (!("Species Richness:" %in% transect[[1]])) {
    stop("data_set must be a dataframe obtained from the universalFQA.org website. Type ?download_assessment for help.", call. = FALSE)
  }

  boundary_rows <- which(grepl("Quadrat", transect$V1) & grepl("Species:", transect$V1))
  lengths <- diff(boundary_rows) - 3
  lengths <- c(lengths, nrow(transect) - tail(boundary_rows, 1) - 2)

  start_rows <- boundary_rows + 2
  end_rows <- start_rows + lengths - 1

  inventory_list <- list(length(start_rows))
  for (subplot in seq_along(start_rows)){
    sub_inv <- transect[start_rows[subplot]:end_rows[subplot],
                        c(1:3, 6:11)]
    colnames(sub_inv) <- c("scientific_name",
                           "family",
                           "acronym",
                           "nativity",
                           "c",
                           "w",
                           "physiognomy",
                           "duration",
                           "common_name")

    sub_inv <- dplyr::na_if(sub_inv, "n/a")
    sub_inv <- dplyr::na_if(sub_inv, "")

    sub_inv <- sub_inv |>
      dplyr::mutate(c = as.numeric(.data$c),
                    w = as.numeric(.data$w))

    inventory_list[[subplot]] <- sub_inv
  }

  inventory_list

}
