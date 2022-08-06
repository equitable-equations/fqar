#' Obtain Species Information From a Universal FQA Transect as a Data Frame
#'
#' @param data_set a data frame downloaded from Universal FQA using download_transect() or other similar function
#' @return A data frame with 6 columns:
#' \itemize{
#'   \item Species (character)
#'   \item Family (character)
#'   \item Acronym (character)
#'   \item Nativity (character)
#'   \item C (numeric)
#'   \item W (numeric)
#'   \item Physiognomy (character)
#'   \item Duration (character)
#'   \item Frequency (numeric)
#'   \item Coverage (numeric)
#'   \item Relative Frequency % (numeric)
#'   \item Relative Coverage % (numeric)
#'   \item Relative Importance Value (numeric)
#' }
#'
#' @import dplyr tidyr
#' @importFrom rlang .data
#'
#' @examples ## transect_inventory can be used with a download function:
#'
#' transect_inventory(download_transect(6325))
#'
#' ## transect_inventory can also be used with saved data from a download function:
#'
#' df <- download_transect(6325)
#' transect_inventory(df)
#' @export

transect_inventory <- function(data_set) {
  
  if (!is.data.frame(data_set)) {stop("data_set must be a dataframe obtained from the universalFQA.org website. Type ?download_transect for help.", call. = FALSE)}

  renamed <- data_set %>%
    rename("one" = 1,
           "two" = 2,
           "three" = 3,
           "four" = 4,
           "five" = 5,
           "six" = 6,
           "seven" = 7,
           "eight" = 8,
           "nine" = 9,
           "ten" = 10,
           "eleven" = 11,
           "twelve" = 12,
           "thirteen" = 13,
           "fourteen" = 14)

  selected <- renamed |> select(1:13)

  data <- selected |>
    filter(row_number() > which(.data$`one` == "Species Relative Importance Values:")) %>%
    filter(row_number() < which(.data$`one` == "Quadrat/Subplot Level Metrics:"))

  dropped <- data |>  drop_na(c(1))

  names(dropped) <- lapply(dropped[1, ], as.character)
  new <- dropped[-1,]

#  new |> mutate_at(c(5:6), as.double) |> mutate_at(c(9:13), as.double)

  new <- new |> mutate(across(c(5:6, 9:13), as.double))
}
