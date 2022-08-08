#' Obtain Overview Information From a Universal FQA Transect as a Data Frame
#'
#' @param data_set a data frame downloaded from Universal FQA using download_transect() or other similar function
#' @return A data frame with 55 columns:
#' \itemize{
#'    \item Title (character)
#'    \item Date (POSIXct)
#'    \item Site Name (character)
#'    \item City (character)
#'    \item County (character)
#'    \item State (character)
#'    \item Country (character)
#'    \item Omernik Level 3 Ecoregion (character)
#'    \item Custom FQA DB Name (character)
#'    \item Custom FQA DB Description (character)
#'    \item FQA DB Region (character)
#'    \item FQA DB Publication Year (character)
#'    \item FQA DB Description (character)
#'    \item FQA DB Selection Name (character)
#'    \item Practitioner (character)
#'    \item Latitude (character)
#'    \item Longitude (character)
#'    \item Community Code (character)
#'    \item Community Name (character)
#'    \item Community Type Notes (character)
#'    \item Weather Notes (character)
#'    \item Duration Notes (character)
#'    \item Environment Description (character)
#'    \item Other Notes (character)
#'    \item Transect/Plot Type (character)
#'    \item Plot Size (m2) (numeric)
#'    \item Quadrat/Subplot Size (m2) (numeric)
#'    \item Transect Length (m) (numeric)
#'    \item Sampling Design Description (character)
#'    \item Cover Method (character)
#'    \item Private/Public (character)
#'    \item Total Mean C (numeric)
#'    \item Cover-weighted Mean C (numeric)
#'    \item Native Mean C (numeric)
#'    \item Total FQI (numeric)
#'    \item Native FQI (numeric)
#'    \item Cover-weighted FQI (numeric)
#'    \item Cover-weighted Native FQI (numeric)
#'    \item Adjusted FQI (numeric)
#'    \item % C value 0 (numeric)
#'    \item % C value 1-3 (numeric)
#'    \item % C value 4-6 (numeric)
#'    \item % C value 7-10 (numeric)
#'    \item Total Species (numeric)
#'    \item Native Species (numeric)
#'    \item Non-native Species (numeric)
#'    \item Species Wetness (numeric)
#'    \item Mean Wetness (numeric)
#'    \item Native Mean Wetness (numeric)
#'    \item Annual (numeric)
#'    \item Perennial (numeric)
#'    \item Biennial (numeric)
#'    \item Native Annual (numeric)
#'    \item Native Perennial (numeric)
#'    \item Native Biennial (numeric)
#' }
#'
#' @import dplyr tidyr
#' @importFrom rlang .data
#'
#' @examples \dontrun{
#' ## transect_glance can be used with a download function:
#'
#' transect_glance(download_transect(6325))
#'
#' ## transect_glance can also be used with saved data from a download function:
#'
#' df <- download_transect(6325)
#' transect_glance(df)
#' }
#'
#' @export
transect_glance <- function(data_set){

    if (!is.data.frame(data_set)) {stop("data_set must be a dataframe obtained from the universalFQA.org website. Type ?download_transect for help.", call. = FALSE)}

    data_set[data_set == ""] <- NA

    data_set[1, 2] <- data_set[1, 1]
    data_set[1, 1] <- "Title"
    data_set[2, 2] <- data_set[2, 1]
    data_set[2, 1] <- "Date"
    data_set[3, 2] <- data_set[3, 1]
    data_set[3, 1] <- "Site Name"
    data_set[4, 2] <- data_set[4, 1]
    data_set[4, 1] <- "City"
    data_set[5, 2] <- data_set[5, 1]
    data_set[5, 1] <- "County"
    data_set[6, 2] <- data_set[6, 1]
    data_set[6, 1] <- "State"
    data_set[7, 2] <- data_set[7, 1]
    data_set[7, 1] <- "Country"
    data_set[8, 2] <- data_set[8, 1]
    data_set[8, 1] <- "Omernik Level 3 Ecoregion"

    renamed <- data_set |>
      rename("one" = 1,
             "two" = 2)

    dropped <- renamed |> drop_na(1) |>
      filter(.data$one != "Conservatism-Based Metrics:",
             .data$one != "Species Richness:",
             .data$one != "Duration Metrics:")

    cut <- dropped |>
      filter(row_number() < which(.data$`one` == "Physiognomic Relative Importance Values:"))

    selected <- cut |> select(1:2)

    if (selected[9, 1] == "FQA DB Region:") {
      new_rows <- data.frame(one = c("Custom FQA DB Name",
                                     "Custom FQA DB Description"),
                             two = c(NA, NA))
      selected <- rbind(selected[1:8, ], new_rows, selected[-(1:8), ])
    }

    selected[11:14, 1] <- gsub("Original ", "", selected[11:14, 1])
    selected[28, 2] <- gsub("m", "", selected[28, 2])

    pivoted <- selected |> pivot_wider(names_from = .data$one,
                                        values_from = .data$two)

    data <- pivoted |> mutate(across(c(26:28, 32:55), as.numeric),
                              Date = as.POSIXct(.data$Date))

    names(data) <- gsub(":", "", names(data))

    data

}


