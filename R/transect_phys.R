#' Obtain physiognometric information for a floristic quality transect assessment
#'
#' \code{transect_phys()} returns a data frame with physiognometric information
#' for a floristic quality transect assessment obtained from
#' \href{https://universalfqa.org/}{universalfqa.org}.
#'
#' @param data_set A data set downloaded from
#'   \href{https://universalfqa.org/}{universalfqa.org} either manually or using
#'   \code{\link[=download_transect]{download_transect()}}.
#'
#' @return  A data frame with 6 columns:
#' \itemize{
#'    \item physiognomy (character)
#'    \item frequency (numeric)
#'    \item coverage (numeric)
#'    \item relative_frequency_percent (numeric)
#'    \item relative_coverage_percent (numeric)
#'    \item relative_importance_value_percent (numeric)
#' }
#'
#' @import dplyr tidyr
#' @importFrom rlang .data

#' @examples
#' # While transect_phys can be used with a .csv file downloaded
#' # manually from the universal FQA website, it is most typically used
#' # in combination with download_transect().
#'
#' \donttest{
#' tyler <- download_transect(6352)
#' transect_phys(tyler)
#' }
#'
#' @export


transect_phys <- function(data_set) {

  empty_df <- data.frame(physiognomy = character(0),
                         frequency = numeric(0),
                         coverage = numeric(0),
                         relative_frequency_percent = numeric(0),
                         relative_coverage_percent = numeric(0)
  )

  if (!is_transect(data_set)) {
    message(
      "data_set must be a dataframe obtained from the universalFQA.org website. Type ?download_transect for help."
    )
    return(invisible(empty_df))
  }

  if (ncol(data_set) == 1) {
    new <- rbind(names(data_set), data_set)

    data_set <- separate(
      new,
      col = 1,
      sep = ",",
      into = paste0("V", 1:14),
      fill = "right",
      extra = "merge"
    )
  }

  data_set <-
    mutate(data_set, across(tidyselect::where(is.character), ~ na_if(.x, "n/a")))
  data_set <-
    mutate(data_set, across(tidyselect::where(is.character), ~ na_if(.x, "")))

  start_row <-
    2 + which(data_set$V1 == "Physiognomic Relative Importance Values:")
  end_row <-
    -2 + which(data_set$V1 == "Species Relative Importance Values:")

  if (length(end_row) == 0) {
    message("No physiognometric data found")
    return(invisible(TRUE))
  }

  tryCatch({
    if (end_row < start_row) {
      message("No physiognometric data found")
      return(invisible(empty_df))
    }
  },

  error = function(e) {
    message("No physiognometric data foundd")
    return(invisible(empty_df))
  },

  warning = function(w){
    message("No physiognometric data found")
    return(invisible(empty_df))
  })

  phys <- data_set[start_row:end_row, 1:6]

  names(phys) <- c(
    "physiognomy",
    "frequency",
    "coverage",
    "relative_frequency_percent",
    "relative_coverage_percent",
    "relative_importance_value_percent"
  )

  suppressWarnings(phys <- phys
                   |>  mutate(across(2:6, as.double)))

}

