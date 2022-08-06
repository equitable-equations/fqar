#' Obtain Physiognomy Information From a Universal FQA Transect as a Data Frame
#'
#' @param data_set a data frame downloaded from Universal FQA using download_transect() or other similar function
#' @return A data frame with 6 columns:
#' \itemize{
#'    \item Physiognomy (character)
#'    \item Frequency (numeric)
#'    \item Coverage (numeric)
#'    \item Relative Frequency % (numeric)
#'    \item Relative Coverage % (numeric)
#'    \item Relative Importance Value (numeric)
#' }
#'
#' @import dplyr tidyr
#' @importFrom rlang .data

#' @examples
#' \dontrun{
#' ## transect_phys can be used with a download function:
#'
#' transect_phys(download_transect(6325))
#'
#' ## transect_phys can also be used with saved data from a download function:
#'
#' df <- download_transect(6325)
#' transect_phys(df)
#' }
#' @export

transect_phys <- function(data_set) {
  
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

  selected <- renamed %>% select(1:6)

  data <- selected %>%
      filter(row_number() > which(.data$`one` == "Physiognomic Relative Importance Values:")) %>%
      filter(row_number() < which(.data$`one` == "Species Relative Importance Values:"))

  dropped <- data %>% drop_na(c(1, 6))

  names(dropped) <- lapply(dropped[1, ], as.character)
  new <- dropped[-1,]

  new %>% mutate_at(c(2:6), as.double)

}

