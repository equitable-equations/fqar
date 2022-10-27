#' Obtain tidy summary information for a floristic quality transect assessment
#'
#' \code{transect_glance()} tidies a floristic quality transect assessment data
#' set obtained from \href{https://universalfqa.org/}{universalfqa.org}.

#' @param data_set A data set downloaded from
#'   \href{https://universalfqa.org/}{universalfqa.org} either manually or using
#'   \code{\link[=download_transect]{download_transect()}}.
#'
#' @return A data frame with 1 row and 54 columns:
#' \itemize{
#'    \item Title (character)
#'    \item Date (date)
#'    \item Site Name (character)
#'    \item City (character)
#'    \item County (character)
#'    \item State (character)
#'    \item Country (character)
#'    \item Omernik Level 3 Ecoregion (character)
#'    \item FQA DB Region (character)
#'    \item FQA DB Publication Year (character)
#'    \item FQA DB Description (character)
#'    \item FQA DB Selection Name (character)
#'    \item Custom FQA DB Name (character)
#'    \item Custom FQA DB Description (character)
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
#'    \item \% C value 0 (numeric)
#'    \item \% C value 1-3 (numeric)
#'    \item \% C value 4-6 (numeric)
#'    \item \% C value 7-10 (numeric)
#'    \item Total Species (numeric)
#'    \item Native Species (numeric)
#'    \item Non-native Species (numeric)
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
#' @examples
#' \donttest{
#' # While transect_glance can be used with a .csv file downloaded manually
#' # from the universal FQA website, it is most typically used in combination
#' # with download_transect().
#'
#' tyler <- download_transect(6352)
#' transect_glance(tyler)
#' }
#'
#' @export
transect_glance <- function(data_set){

  if (!is.data.frame(data_set)) {
    stop("data_set must be a dataframe obtained from the universalFQA.org website. Type ?download_transect for help.", call. = FALSE)
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
  data_set <- na_if(data_set, "0000-00-00")

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

  names(data_set)[1:2] <- c("V1", "V2")

  dropped <- data_set |> drop_na(1) |>
    filter(.data$V1 != "Conservatism-Based Metrics:",
           .data$V1 != "Species Richness:",
           .data$V1 != "Duration Metrics:",
           .data$V1 != "Species Wetness:")

  cut <- dropped |>
    filter(row_number() < which(.data$V1 == "Physiognomic Relative Importance Values:"))

  selected <- cut |> select(1:2)

  if (selected[9, 1] == "FQA DB Region:") {
    new_rows <- data.frame(V1 = c("Custom FQA DB Name",
                                   "Custom FQA DB Description"),
                           V2 = c(NA, NA))
    selected <- rbind(selected[1:12, ], new_rows, selected[-(1:12), ])
  } else {
    selected[1:14, ] <- selected[c(1:8, 11:14, 9:10), ]
    }

  selected$V1 <- gsub("Original ", "", selected$V1)
  selected$V2[28] <- sub("m", "", selected$V2[28])

  pivoted <- selected |> pivot_wider(names_from = .data$V1,
                                     values_from = .data$V2)

  suppressWarnings(data <- pivoted |>
                     mutate(across(c(26:28, 32:54), as.numeric),
                            Date = as.Date(.data$Date)))

  names(data) <- gsub(":", "", names(data))

  data
}


