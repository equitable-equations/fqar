#' Obtain tidy summary information for a floristic quality assessment
#'
#' \code{assessment_glance()} tidies a floristic quality assessment data set
#' obtained from \href{https://universalfqa.org/}{universalfqa.org}.
#'
#' @param data_set A data set downloaded from
#'   \href{https://universalfqa.org/}{universalfqa.org} either manually or using
#'   \code{\link[=download_assessment]{download_assessment()}}
#'
#' @return A data frame with 53 columns:
#' \itemize{
#'    \item assessment_id (numeric)
#'    \item title (character)
#'    \item date (date)
#'    \item site_name (character)
#'    \item city (character)
#'    \item county (character)
#'    \item state (character)
#'    \item country (character)
#'    \item fqa_db_region (character)
#'    \item fqa_db_publication_year (character)
#'    \item fqa_db_description (character)
#'    \item custom_fqa_db_name (character)
#'    \item custom_fqa_db_description (character)
#'    \item practitioner (character)
#'    \item latitude (character)
#'    \item longitude (character)
#'    \item weather_notes (character)
#'    \item duration_notes (character)
#'    \item community_type_notes (character)
#'    \item other_notes (character)
#'    \item private_public (character)
#'    \item total_mean_c (numeric)
#'    \item native_mean_c (numeric)
#'    \item total_fqi (numeric)
#'    \item native_fqi (numeric)
#'    \item adjusted_fqi (numeric)
#'    \item c_value_zero (numeric) Percent of c-values 0
#'    \item c_value_low (numeric) Percent of c-values 1-3
#'    \item c_value_mid (numeric) Percent of c-values 4-6
#'    \item c_value_high (numeric) Percent of c-values 7-10
#'    \item native_tree_mean_c (numeric)
#'    \item native_shrub_mean_c (numeric)
#'    \item native_herbaceous_mean_c (numeric)
#'    \item total_species (numeric)
#'    \item native_species (numeric)
#'    \item non_native_species (numeric)
#'    \item mean_wetness (numeric)
#'    \item native_mean_wetness (numeric)
#'    \item tree (numeric)
#'    \item shrub (numeric)
#'    \item vine (numeric)
#'    \item forb (numeric)
#'    \item grass (numeric)
#'    \item sedge (numeric)
#'    \item rush (numeric)
#'    \item fern (numeric)
#'    \item bryophyte (numeric)
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
#' # While assessment_glance can be used with a .csv file downloaded manually
#' # from the universal FQA website, it is most typically used in combination
#' # with download_assessment().
#'
#' edison <- download_assessment(25002)
#' assessment_glance(edison)
#'
#' @export


assessment_glance <- function(data_set) {

  df_bad <- data.frame(assessment_id = numeric(0),
                       title = character(0),
                       date = numeric(0),
                       site_name = character(0),
                       city = character(0),
                       county = character(0),
                       state = character(0),
                       country = character(0),
                       fqa_db_region = character(0),
                       fqa_db_publication_year = character(0),
                       fqa_db_description = character(0),
                       custom_fqa_db_name = character(0),
                       custom_fqa_db_description = character(0),
                       practitioner = character(0),
                       latitude = character(0),
                       longitude = character(0),
                       weather_notes = character(0),
                       duration_notes = character(0),
                       community_type_notes = character(0),
                       other_notes = character(0),
                       private_public = character(0),
                       total_mean_c = numeric(0),
                       native_mean_c = numeric(0),
                       total_fqi = numeric(0),
                       native_fqi = numeric(0),
                       adjusted_fqi = numeric(0),
                       c_value_zero = numeric(0),
                       c_value_low = numeric(0),
                       c_value_mid = numeric(0),
                       c_value_high = numeric(0),
                       native_tree_mean_c = numeric(0),
                       native_shrub_mean_c = numeric(0),
                       native_herbaceous_mean_c = numeric(0),
                       total_species = numeric(0),
                       native_species = numeric(0),
                       non_native_species = numeric(0),
                       mean_wetness = numeric(0),
                       native_mean_wetness = numeric(0),
                       tree = numeric(0),
                       shrub = numeric(0),
                       vine = numeric(0),
                       forb = numeric(0),
                       grass = numeric(0),
                       sedge = numeric(0),
                       rush = numeric(0),
                       fern = numeric(0),
                       bryophyte = numeric(0),
                       annual = numeric(0),
                       perennial = numeric(0),
                       biennial = numeric(0),
                       native_annual = numeric(0),
                       native_perennial = numeric(0),
                       native_biennial = numeric(0)
  )

  df_bad$date <- as.Date(df_bad$date)

  if (is.null(data_set)) {
    message("data_set is NULL. Empty data frame returned.")
    return(invisible(df_bad))
  }

  if (!is.data.frame(data_set)) {
    message(
      "data_set must be a dataframe obtained from the universalFQA.org website. Type ?download_assessment for help."
    )
    return(invisible(df_bad))
  }

  if (nrow(data_set) == 0) {
    message(
      "Input data_set is empty."
    )
    return(invisible(df_bad))
  }

  if (!("Species Richness:" %in% data_set[[1]])) {
    message(
      "data_set must be a dataframe obtained from the universalFQA.org website. Type ?download_assessment for help."
    )
    return(invisible(df_bad))
  }

  if (ncol(data_set) == 1) {
    new <- rbind(names(data_set),
                 data_set)

    data_set <- separate(
      new,
      col = 1,
      sep = ",",
      into = paste0("V", 1:9),
      fill = "right",
      extra = "merge"
    )
    idnum <- NA
  } else {
    idnum <- data_set[1,1]
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

  names(data_set)[1:2] <- c("V1", "V2")

  selected <- data_set[1:2] |>
    drop_na(1)

  if (selected[8, 1] == "FQA DB Region:") {
    new_rows <- data.frame(
      V1 = c("Custom FQA DB Name",
             "Custom FQA DB Description"),
      V2 = c(NA, NA)
    )
    selected <- rbind(selected[1:10,],
                      new_rows, selected[-(1:10),])
  } else {
    selected[1:12,] <- selected[c(1:7, 10:12, 8:9),]
    selected$V1 <- gsub("Original ", "", selected$V1)
  }

  small <- selected |>
    filter(row_number() < which(.data$V1 == "Species:"))

  id_df <- data.frame(V1 = "assessment_id",
                      V2 = idnum)
  colnames(id_df) <- c("V1", "V2")
  small <- rbind(id_df, small)

  pivoted <- small |> pivot_wider(names_from = "V1",
                                  values_from = "V2")


  suppressWarnings(final <- pivoted |>
                     mutate(across(23:58, as.double),
                            Date = as.Date(.data$Date,
                                           "%m/%d/%y")))
  final <- final |>
    select(
      -c(
        "Duration Metrics:",
        "Physiognomy Metrics:",
        "Conservatism-Based Metrics:",
        "Species Richness:",
        "Species Wetness:"
      )
    )

  names(final) <- c(
    "assessmemnt_id",
    "title",
    "date",
    "site_name",
    "city",
    "county",
    "state",
    "country",
    "fqa_db_region",
    "fqa_db_publication_year",
    "fqa_db_description",
    "custom_fqa_db_name",
    "custom_fqa_db_description",
    "practitioner",
    "latitude",
    "longitude",
    "weather_notes",
    "duration_notes",
    "community_type_notes",
    "other_notes",
    "private_public",
    "total_mean_c",
    "native_mean_c",
    "total_fqi",
    "native_fqi",
    "adjusted_fqi",
    "c_value_zero",
    "c_value_low",
    "c_value_mid",
    "c_value_high",
    "native_tree_mean_c",
    "native_shrub_mean_c",
    "native_herbaceous_mean_c",
    "total_species",
    "native_species",
    "non_native_species",
    "mean_wetness",
    "native_mean_wetness",
    "tree",
    "shrub",
    "vine",
    "forb",
    "grass",
    "sedge",
    "rush",
    "fern",
    "bryophyte",
    "annual",
    "perennial",
    "biennial",
    "native_annual",
    "native_perennial",
    "native_biennial"
  )

  final

}
