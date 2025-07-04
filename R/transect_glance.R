#' Obtain tidy summary information for a floristic quality transect assessment
#'
#' \code{transect_glance()} tidies a floristic quality transect assessment data
#' set obtained from \href{https://universalfqa.org/}{universalfqa.org}.

#' @param data_set A data set downloaded from
#'   \href{https://universalfqa.org/}{universalfqa.org} either manually or using
#'   \code{\link[=download_transect]{download_transect()}}.
#'
#' @return A data frame with 1 row and 55 columns:
#' \itemize{
#'    \item transect_id (numeric)
#'    \item title (character)
#'    \item date (date)
#'    \item site_name (character)
#'    \item city (character)
#'    \item county (character)
#'    \item state (character)
#'    \item country (character)
#'    \item omernik_level_three_ecoregion (character)
#'    \item fqa_db_region (character)
#'    \item fqa_db_publication_year (character)
#'    \item fqa_db_description (character)
#'    \item fqa_db_selection_name (character)
#'    \item custom_fqa_db_name (character)
#'    \item custom_fqa_db_description (character)
#'    \item practitioner (character)
#'    \item latitude (character)
#'    \item longitude (character)
#'    \item community_code (character)
#'    \item community_name (character)
#'    \item community_type_notes (character)
#'    \item weather_notes (character)
#'    \item duration_notes (character)
#'    \item environment_description (character)
#'    \item other_notes (character)
#'    \item transect_plot_type (character)
#'    \item plot_size (numeric) Plot size in square meters
#'    \item quadrat_subplot_size (numeric) Quadrat or subplot size in square meters
#'    \item transect_length (numeric) Transect length in meters
#'    \item sampling_design_description (character)
#'    \item cover_method (character)
#'    \item private_public (character)
#'    \item total_mean_c (numeric)
#'    \item cover_weighted_mean_c (numeric)
#'    \item native_mean_c (numeric)
#'    \item total_fqi (numeric)
#'    \item native_fqi (numeric)
#'    \item cover_weighted_fqi (numeric)
#'    \item cover_weighted_native_fqi (numeric)
#'    \item adjusted_fqi (numeric)
#'    \item c_value_zero (numeric) Percent of c-values 0
#'    \item c_value_low (numeric) Percent of c-values 1-3
#'    \item c_value_mid (numeric) Percent of c-values 4-6
#'    \item c_value_high (numeric) Percent of c-values 7-10
#'    \item total_species (numeric)
#'    \item native_species (numeric)
#'    \item non_native_species (numeric)
#'    \item mean_wetness (numeric)
#'    \item native_mean_wetness (numeric)
#'    \item annual (numeric)
#'    \item perennial (numeric)
#'    \item biennial (numeric)
#'    \item native_annual (numeric)
#'    \item native_perennial (numeric)
#'    \item native_biennial (numeric)
#' }
#'
#' @import dplyr tidyr
#' @importFrom rlang .data
#'
#' @examples
#' # While transect_glance can be used with a .csv file downloaded manually
#' # from the universal FQA website, it is most typically used in combination
#' # with download_transect().
#'
#' \donttest{
#' tyler <- download_transect(6352)
#' transect_glance(tyler)
#' }
#'
#' @export


transect_glance <- function(data_set) {

  bad_df <- data.frame(
    transect_id = numeric(0),
    title = character(0),
    date = numeric(0),
    site_name = character(0),
    city = character(0),
    county = character(0),
    state = character(0),
    country = character(0),
    omernik_level_three_ecoregion = character(0),
    fqa_db_region = character(0),
    fqa_db_publication_year = character(0),
    fqa_db_description = character(0),
    fqa_db_selection_name = character(0),
    custom_fqa_db_name = character(0),
    custom_fqa_db_description = character(0),
    practitioner = character(0),
    latitude = character(0),
    longitude = character(0),
    community_code = character(0),
    community_name = character(0),
    community_type_notes = character(0),
    weather_notes = character(0),
    duration_notes = character(0),
    environment_description = character(0),
    other_notes = character(0),
    transect_plot_type = character(0),
    plot_size = numeric(0),
    quadrat_subplot_size = numeric(0),
    transect_length = numeric(0),
    sampling_design_description = character(0),
    cover_method = character(0),
    private_public = character(0),
    total_mean_c = numeric(0),
    cover_weighted_mean_c = numeric(0),
    native_mean_c = numeric(0),
    total_fqi = numeric(0),
    native_fqi = numeric(0),
    cover_weighted_fqi = numeric(0),
    cover_weighted_native_fqi = numeric(0),
    adjusted_fqi = numeric(0),
    c_value_zero = numeric(0),
    c_value_low = numeric(0),
    c_value_mid = numeric(0),
    c_value_high = numeric(0),
    total_species = numeric(0),
    native_species = numeric(0),
    non_native_species = numeric(0),
    mean_wetness = numeric(0),
    native_mean_wetness = numeric(0),
    annual = numeric(0),
    perennial = numeric(0),
    biennial = numeric(0),
    native_annual = numeric(0),
    native_perennial = numeric(0),
    native_biennial = numeric(0)
  )

  bad_df$date <- as.Date(bad_df$date)

  class(bad_df) <- c("tbl_df",
                     "tbl",
                     "data.frame")

  if (!is.data.frame(data_set)) {
    message(
      "data_set must be a dataframe obtained from the universalFQA.org website. Type ?download_transect for help."
    )
    return(invisible(bad_df))
  }

  if ((ncol(data_set) == 0) | nrow(data_set) == 0) {
    message(
      "data_set must be a dataframe obtained from the universalFQA.org website. Type ?download_transect for help."
    )
    return(invisible(bad_df))
  }

  if (!("Species Richness:" %in% data_set[[1]])) {
    message(
      "data_set must be a dataframe obtained from the universalFQA.org website. Type ?download_transect for help."
    )
    return(invisible(bad_df))
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
    transect_id <- NA
  } else {
    transect_id <- data_set[1,1]
    data_set <- data_set[2:nrow(data_set), ]
  }

  data_set <-
    mutate(data_set, across(tidyselect::where(is.character), ~ na_if(.x, "n/a")))
  data_set <-
    mutate(data_set, across(tidyselect::where(is.character), ~ na_if(.x, "")))
  data_set <-
    mutate(data_set, across(tidyselect::where(is.character), ~ na_if(.x, "0000-00-00")))

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
    filter(
      .data$V1 != "Conservatism-Based Metrics:",
      .data$V1 != "Species Richness:",
      .data$V1 != "Duration Metrics:",
      .data$V1 != "Species Wetness:"
    )

  cut <- dropped |>
    filter(row_number() < which(.data$V1 == "Physiognomic Relative Importance Values:"))

  selected <- cut[1:2]

  if (selected[9, 1] == "FQA DB Region:") {
    new_rows <- data.frame(
      V1 = c("Custom FQA DB Name",
             "Custom FQA DB Description"),
      V2 = c(NA, NA)
    )
    selected <-
      rbind(selected[1:12,], new_rows, selected[-(1:12),])
  } else {
    selected[1:14,] <- selected[c(1:8, 11:14, 9:10),]
  }

  selected$V1 <- gsub("Original ", "", selected$V1)
  selected$V2[28] <- sub("m", "", selected$V2[28])

  pivoted <- selected |> pivot_wider(names_from = "V1",
                                     values_from = "V2")

  pivoted <- cbind(transect_id = transect_id, pivoted)

  suppressWarnings(data <- pivoted |>
                     mutate(across(c(27:29, 33:55), as.numeric),
                            Date = as.Date(.data$Date,
                                           "%m/%d/%y")))

  names(data) <- gsub(":", "", names(data))

  names(data) <- c(
    "transect_id",
    "title",
    "date",
    "site_name",
    "city",
    "county",
    "state",
    "country",
    "omernik_level_three_ecoregion",
    "fqa_db_region",
    "fqa_db_publication Year",
    "fqa_db_description",
    "fqa_db_selection_name",
    "custom_fqa_db_name",
    "custom_fqa_db_description",
    "practitioner",
    "latitude",
    "longitude",
    "community_code",
    "community_name",
    "community_type_notes",
    "weather_notes",
    "duration_notes",
    "environment_description",
    "other_notes",
    "transect_plot_type",
    "plot_size",
    "quadrat_subplot_size",
    "transect_length",
    "sampling_design_description",
    "cover_method",
    "private_public",
    "total_mean_c",
    "cover_weighted_mean_c",
    "native_mean_c",
    "total_fqi",
    "native_fqi",
    "cover_weighted_fqi",
    "cover_weighted_native_fqi",
    "adjusted_fqi",
    "c_value_zero",
    "c_value_low",
    "c_value_mid",
    "c_value_high",
    "total_species",
    "native_species",
    "non_native_species",
    "mean_wetness",
    "native_mean_wetness",
    "annual",
    "perennial",
    "biennial",
    "native_annual",
    "native_perennial",
    "native_biennial"
  )

  data

  }


