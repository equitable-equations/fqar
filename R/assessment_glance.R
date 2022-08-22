#' Obtain tidy summary information for a floristic quality assessment
#'
#' \code{assessment_glance()} tidies a floristic quality assessment data set
#' obtained from \href{https://universalfqa.org/}{universalfqa.org}.
#'
#' @param data_set A data set downloaded from
#'   \href{https://universalfqa.org/}{universalfqa.org} either manually or using
#'   \code{\link[=download_assessment]{download_assessment()}}
#'
#' @return A data frame with 52 columns:
#' \itemize{
#'    \item Title (character)
#'    \item Date (date)
#'    \item Site Name (character)
#'    \item City (character)
#'    \item County (character)
#'    \item State (character)
#'    \item Country (character)
#'    \item FQA DB Region (character)
#'    \item FQA DB Publication Year (character)
#'    \item FQA DB Description (character)
#'    \item Custom FQA DB Name (character)
#'    \item Custom FQA DB Description (character)
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
#'    \item Total FQI: (numeric)
#'    \item Native FQI (numeric)
#'    \item Adjusted FQI (numeric)
#'    \item \% C value 0 (numeric)
#'    \item \% C value 1-3 (numeric)
#'    \item \% C value 4-6 (numeric)
#'    \item \% C value 7-10 (numeric)
#'    \item Native Tree Mean C (numeric)
#'    \item Native Shrub Mean C (numeric)
#'    \item Native Herbaceous Mean C (numeric)
#'    \item Total Species (numeric)
#'    \item Native Species (numeric)
#'    \item Non-native Species
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
#'    \item Native Perennial (numeric)
#'    \item Native Biennial (numeric)
#' }
#'
#' @import dplyr tidyr
#' @importFrom rlang .data
#'
#' @examples
#' # While assessment_glance can be used with a .csv file downloaded manually
#' # from the universal FQA website, it is most typically used in combination
#' # with download_assessment().
#'
#' edison <- download_assessment(25002)
#' assessment_glance(edison)
#'
#' @export
assessment_glance <- function(data_set) {

  if (!is.data.frame(data_set)) {
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
                         into = paste0("V", 1:9),
                         fill = "right")
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

  names(data_set)[1:2] <- c("V1", "V2")

  selected <- data_set |>
    select(1:2) |>
    drop_na(1)

  if (selected[8, 1] == "FQA DB Region:") {
    new_rows <- data.frame(V1 = c("Custom FQA DB Name",
                                   "Custom FQA DB Description"),
                           V2 = c(NA, NA))
    selected <- rbind(selected[1:10, ], new_rows, selected[-(1:10), ])
  } else {
    selected[1:12, ] <- selected[c(1:7, 10:12, 8:9), ]
    selected$V1 <- gsub("Original ", "", selected$V1)
  }

  small <- selected |>
    filter(row_number() < which(.data$V1 == "Species:"))

  pivoted <- small |> pivot_wider(names_from = .data$V1,
                                  values_from = .data$V2)

  suppressWarnings(final <- pivoted |>
                     mutate(across(22:57, as.double),
                            Date = as.Date(.data$Date)))
  final <- final |>
    select(-c(.data$`Duration Metrics:`,
              .data$`Physiognomy Metrics:`,
              .data$`Conservatism-Based Metrics:`,
              .data$`Species Richness:`,
              .data$`Species Wetness:`))

  names(final) <- gsub(":", "", names(final))

  final
}
