#' Obtain species details for a floristic quality assessment
#'
#' \code{assessment_inventory()} returns a data frame of all plant species
#' included in a floristic quality assessment obtained from
#' \href{https://universalfqa.org/}{universalfqa.org}.
#'
#' @param data_set A data set downloaded from
#'   \href{https://universalfqa.org/}{universalfqa.org} either manually or using
#'   \code{\link[=download_assessment]{download_assessment()}}.

#' @return A data frame with 9 columns:
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
#' }
#'
#' @import dplyr tidyr
#' @importFrom rlang .data
#'
#' @examples
#' # While assessment_glance can be used with a .csv file downloaded
#' # manually from the universal FQA website, it is most typically used
#' # in combination with download_assessment().
#'
#' edison <- download_assessment(25002)
#' assessment_inventory(edison)
#'
#' @export


assessment_inventory <- function(data_set) {

  df_bad <- data.frame(scientific_name = character(0),
                       family = character(0),
                       acronym = character(0),
                       nativity = character(0),
                       c = numeric(0),
                       w = numeric(0),
                       physiognomy = character(0),
                       duration = character(0),
                       common_name = character(0))

  if (!is.data.frame(data_set)) {
    message(
      "data_set must be a dataframe obtained from universalFQA.org. Type ?download_assessment for help."
    )
    return(invisible(df_bad))
  }

  if (ncol(data_set) == 0) {
    message(
      "data_set must be a dataframe obtained from the universalFQA.org website. Type ?download_assessment for help."
    )
    return(invisible(df_bad))
  }

  if (!("Species Richness:" %in% data_set[[1]])) {
    message(
      "data_set must be a dataframe obtained from universalFQA.org. Type ?download_assessment for help."
    )
    return(invisible(df_bad))
  }

  if (ncol(data_set) == 1) {
    new <- rbind(names(data_set), data_set)

    data_set <- separate(
      new,
      col = 1,
      sep = ",",
      into = paste0("V", 1:9),
      fill = "right",
      extra = "merge"
    )
  }

  data_set <-
    mutate(data_set, across(tidyselect::where(is.character), ~ na_if(.x, "n/a")))
  data_set <-
    mutate(data_set, across(tidyselect::where(is.character), ~ na_if(.x, "")))

  renamed <- data_set |>
    rename(
      "scientific_name" = 1,
      "family" = 2,
      "acronym" = 3,
      "nativity" = 4,
      "c" = 5,
      "w" = 6,
      "physiognomy" = 7,
      "duration" = 8,
      "common_name" = 9
    )

  new <- renamed |>
    filter(row_number() > which(.data$scientific_name == "Scientific Name"))
  new <- suppressWarnings(mutate(new, across(5:6, as.numeric)))

  class(new) <- c("tbl_df", "tbl", "data.frame")

  new
}
