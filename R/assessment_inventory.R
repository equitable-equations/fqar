#' Obtain Study Information From Universal FQA Inventory as a Data Frame
#'
#' @param data_set a data frame downloaded from Universal FQA using download_assessment() or directly from universalfqa.org
#' @return A data frame with 9 columns:
#' \itemize{
#'    \item Scientific Name (character)
#'    \item Family (character)
#'    \item Acronym (character)
#'    \item Native? (character)
#'    \item C (numeric)
#'    \item W (numeric)
#'    \item Physiognomy (character)
#'    \item Duration (character)
#'    \item Common Name (character)
#' }
#'
#' @import dplyr tidyr
#' @importFrom rlang .data
#'
#' @examples
#' \dontrun{
#' ## assessment_inventory can be used with a .csv file downloaded from the universal FQA website:
#'
#' assessment_inventory(open_dunes)
#'
#' ## or with a download function:
#'
#' assessment_inventory(download_assessment(25002))
#'
#' ## assessment_inventory can also be used with saved data from a download function:
#'
#' df <- download_fqa(25002)
#' assessment_inventory(df)
#' }
#' @export

assessment_inventory <- function(data_set) {

  if (!is.data.frame(data_set)) {stop("data_set must be a dataframe obtained from the universalFQA.org website. Type ?download_assessment for help.", call. = FALSE)}

  if (ncol(data_set) == 1) {

    new <- rbind(names(data_set), data_set)

    data <- separate(new,
                     col = 1,
                     sep = ",",
                     into = c("V1", "V2", "V3", "V4",
                              "V5", "V6", "V7", "V8", "V9"))

    renamed <- data %>%
      rename("Scientific Name" = 1,
             "Family" = 2,
             "Acronym" = 3,
             "Native?" = 4,
             "C" = 5,
             "W" = 6,
             "Physiognomy" = 7,
             "Duration" = 8,
             "Common Name" = 9)

    new <- renamed %>%
      filter(row_number() > which(.data$`Scientific Name` == "Scientific Name"))

    new %>% mutate_at(c(5:6), as.numeric)

  } else {

    renamed <- data_set %>%
      rename("Scientific Name" = 1,
             "Family" = 2,
             "Acronym" = 3,
             "Native?" = 4,
             "C" = 5,
             "W" = 6,
             "Physiognomy" = 7,
             "Duration" = 8,
             "Common Name" = 9)

    new <- renamed %>%
      filter(row_number() > which(.data$`Scientific Name` == "Scientific Name"))

    new %>% mutate_at(c(5:6), as.numeric)

  }

}
