#' Obtain Overview Information From a Universal FQA Inventory as a Data Frame
#'
#' @param data_set a data frame downloaded from Universal FQA using download_assessment() or directly from universalfqa.org
#' @return A data frame with 52 columns:
#' \itemize{
#'    \item Title (character)
#'    \item Date (POSIXct)
#'    \item Site Name (character)
#'    \item City (character)
#'    \item County (character)
#'    \item State (character)
#'    \item Country (character)
#'    \item FQA DB Region (character)
#'    \item FQA DB Publication Year (character)
#'    \item FQA DB Description (character)
#'    \item Practitioner (character)
#'    \item Latitude (character)
#'    \item Longitude (character)
#'    \item Weather Notes (character)
#'    \item Duration Notes (character)
#'    \item Community Type Notes (character)
#'    \item Other Notes (character)
#'    \item Private/Public (character)
#'    \item Total Mean C (numeric)
#'    \item Native Mean C (numeric)
#'    \item Total FQI (numeric)
#'    \item Native FQI (numeric)
#'    \item Adjusted FQI (numeric)
#'    \item % C value 0 (numeric)
#'    \item % C value 1-3 (numeric)
#'    \item % C value 4-6 (numeric)
#'    \item % C value 7-10 (numeric)
#'    \item Native Tree Mean C (numeric)
#'    \item Native Shrub Mean C (numeric)
#'    \item Native Herbaceous Mean C (numeric)
#'    \item Species Richness (numeric)
#'    \item Total Species (numeric)
#'    \item Native Species (numeric)
#'    \item Non-native Species (numeric)
#'    \item Species Wetness (numeric)
#'    \item Mean Wetness (numeric)
#'    \item Native Mean Wetness (numeric)
#'    \item Tree (numeric)
#'    \item Shrub (numeric)
#'    \item Vine (numeric)
#'    \item Forb (numeric)
#'    \item Grass (numeric)
#'    \item Sedge (numeric)
#'    \item Rush (numeric)
#'    \item Fern (numeric)
#'    \item Bryophyte (numeric)
#'    \item Annual (numeric)
#'    \item Perennial (numeric)
#'    \item Biennial (numeric)
#'    \item Native Annual (numeric)
#'    \item Native Perennial: (numeric)
#'    \item Native Biennial: (numeric)
#' }
#'
#' @import dplyr tidyr
#' @importFrom rlang .data
#'
#' @examples \dontrun{
#' ## assessment_glance can be used with a .csv file downloaded from the universal FQA website:
#'
#' assessment_glance(open_dunes)
#'
#' ## or with a download function:
#'
#' assessment_glance(download_assessment(25002))
#'
#' ## assessment_glance can also be used with saved data from a download function:
#'
#' df <- download_assessment(25002)
#' assessment_glance(df)
#' }
#'
#' @export
assessment_glance <- function(data_set) {

  if (!is.data.frame(data_set)) {stop("data_set must be a dataframe obtained from the universalFQA.org website. Type ?download_assessment for help.", call. = FALSE)}

  # when an fqa is downloaded from universalfqa.org to a computer as a .csv file and uploaded to R, the output is a single column data frame. This if-else statement fixes that issue.
  # Each set should have a row "Physiognomy Metrics:" that is near the bottom of the set.
  # one row might look like this -> Private/Public:,Public however, each set has different data.

  if (ncol(data_set) == 1) {

    new <- rbind(names(data_set), data_set)

    data <- separate(new,
                     col = 1,
                     sep = ",",
                     into = c("V1", "V2", "V3", "V4",
                              "V5", "V6", "V7", "V8", "V9"))

    data[data == ""] <- NA

    data[1, 2] <- data[1, 1]
    data[1, 1] <- "Title"
    data[2, 2] <- data[2, 1]
    data[2, 1] <- "Date"
    data[3, 2] <- data[3, 1]
    data[3, 1] <- "Site Name"
    data[4, 2] <- data[4, 1]
    data[4, 1] <- "City"
    data[5, 2] <- data[5, 1]
    data[5, 1] <- "County"
    data[6, 2] <- data[6, 1]
    data[6, 1] <- "State"
    data[7, 2] <- data[7, 1]
    data[7, 1] <- "Country"

    renamed <- data |>
      rename("one" = 1,
             "two" = 2,
             "three" = 3,
             "four" = 4,
             "five" = 5,
             "six" = 6,
             "seven" = 7,
             "eight" = 8,
             "nine" = 9)

    selected <- renamed |>
      select(1:2) |> drop_na(1)

    small <- selected |>
      filter(row_number() < which(.data$`one` == "Species:"))

    pivoted <- small |> pivot_wider(names_from = .data$`one`,
                                    values_from = .data$`two`)

    pivoted <- pivoted |> mutate(across(20:55, as.double),
                                 `Date:` = as.POSIXct(.data$`Date:`))
    select(-.data$`Duration Metrics:`, -.data$`Physiognomy Metrics:`, -.data$`Conservatism-Based Metrics:`)

  } else {

    data_set[data_set == ""] <- NA

    data_set[1, 2] <- data_set[1, 1]
    data_set[1, 1] <- "Title:"
    data_set[2, 2] <- data_set[2, 1]
    data_set[2, 1] <- "Date:"
    data_set[3, 2] <- data_set[3, 1]
    data_set[3, 1] <- "Site Name:"
    data_set[4, 2] <- data_set[4, 1]
    data_set[4, 1] <- "City:"
    data_set[5, 2] <- data_set[5, 1]
    data_set[5, 1] <- "County:"
    data_set[6, 2] <- data_set[6, 1]
    data_set[6, 1] <- "State:"
    data_set[7, 2] <- data_set[7, 1]
    data_set[7, 1] <- "Country:"

    renamed <- data_set |>
      rename("one" = 1,
             "two" = 2,
             "three" = 3,
             "four" = 4,
             "five" = 5,
             "six" = 6,
             "seven" = 7,
             "eight" = 8,
             "nine" = 9)

    selected <- renamed |>
      select(1:2) |> drop_na(1)

    small <- selected |>
      filter(row_number() < which(.data$`one` == "Species:"))

    pivoted <- pivoted <- small |> pivot_wider(names_from = .data$`one`,
                                               values_from = .data$`two`)

    final <- pivoted |> mutate(across(20:55, as.double),
                               `Date:` = as.POSIXct(.data$`Date:`)) |>
      select(-.data$`Duration Metrics:`, -.data$`Physiognomy Metrics:`, -.data$`Conservatism-Based Metrics:`)

    names(final) <- gsub(":", "", names(final))

  }

  final

}
