#' Obtain species details for a floristic quality transect assessment
#'
#' \code{transect_inventory()} returns a data frame of all plant species
#' included in a floristic quality transect assessment obtained from
#' \href{https://universalfqa.org/}{universalfqa.org}.
#'
#' @param data_set A data set downloaded from
#'   \href{https://universalfqa.org/}{universalfqa.org} either manually or using
#'   \code{\link[=download_transect]{download_transect()}}.
#'
#' @return A data frame with 13 columns:
#' \itemize{
#'   \item species (character)
#'   \item family (character)
#'   \item acronym (character)
#'   \item nativity (character)
#'   \item c (numeric)
#'   \item w (numeric)
#'   \item physiognomy (character)
#'   \item duration (character)
#'   \item frequency (numeric)
#'   \item coverage (numeric)
#'   \item relative_frequency_percent (numeric)
#'   \item relative_coverage_percent (numeric)
#'   \item relative_importance_value (numeric)
#' }
#'
#' @import dplyr tidyr
#' @importFrom rlang .data
#'
#' @examples
#' # while transect_glance can be used with a .csv file downloaded
#' # manually from the universal FQA website, it is most typically used
#' # in combination with download_transect().
#' \donttest{
#' tyler <- download_transect(6352)
#' transect_inventory(tyler)
#' }
#'
#' @export

transect_inventory <- function(data_set) {

  if (!is.data.frame(data_set)) {
    stop("data_set must be a dataframe obtained from the universalFQA.org website. Type ?download_assessment for help.", call. = FALSE)
  }
  if (ncol(data_set) == 0){
    stop("data_set must be a dataframe obtained from the universalFQA.org website. Type ?download_assessment for help.", call. = FALSE)
  }
  if (!("Species Richness:" %in% data_set[[1]])) {
    stop("data_set must be a dataframe obtained from the universalFQA.org website. Type ?download_assessment for help.", call. = FALSE)
  }

  if (ncol(data_set) == 1) {

    new <- rbind(names(data_set), data_set)

    data_set <- separate(new,
                         col = 1,
                         sep = ",",
                         into = paste0("V", 1:14),
                         fill = "right",
                         extra = "merge")
  }

  data_set <- na_if(data_set, "n/a")
  data_set <- na_if(data_set, "")

  data_set <- data_set |> select(1:13)

  start_row <- 1 + which(data_set$V1 == "Species Relative Importance Values:")
  end_row <- -2 + which(data_set$V1 == "Quadrat/Subplot Level Metrics:")
  if (end_row < start_row) {
    stop("No species listings found.")
    }

  dropped <- data_set[start_row:end_row, ]

  colnames(dropped) <- lapply(dropped[1, ], as.character)
  dropped <- dropped[-1, ]

  suppressWarnings(new <- dropped |>
                     mutate(across(c(5:6, 9:13), as.double)))

  class(new) <- c("tbl_df", "tbl", "data.frame")

  names <- c("species",
             "family",
             "acronym",
             "nativity",
             "c",
             "w",
             "physiognomy",
             "duration",
             "frequency",
             "coverage",
             "relative_frequency_percent",
             "relative_coverage_percent",
             "relative_importance_value")
  colnames(new) <- names

  new
}
