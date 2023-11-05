#' Obtain tidy summary information for a floristic quality database
#'
#' \code{database_glance()} tidies a floristic quality database
#' obtained from \href{https://universalfqa.org/}{universalfqa.org}.
#'
#' @param database A database downloaded from
#'   \href{https://universalfqa.org/}{universalfqa.org} either manually or using
#'   \code{\link[=download_database]{download_database()}}
#'
#' @return A data frame with 8 columns:
#' \itemize{
#'    \item region (character)
#'    \item year (numeric)
#'    \item description (character)
#'    \item total_species (numeric)
#'    \item native_species (numeric)
#'    \item non_native_species (numeric)
#'    \item total_mean_c (numeric)
#'    \item native_mean_c (numeric)
#' }
#'
#' @import tidyr dplyr
#'
#' @examples
#' # While database_glance can be used with a .csv file downloaded manually
#' # from the universal FQA website, it is most typically used in combination
#' # with download_database().
#'
#' chicago_db <- download_database(database_id = 1)
#' chicago_db_summary <- database_glance(chicago_db)
#'
#' @export

database_glance <- function(database) {

  bad_df <- data.frame(
    region = character(0),
    year = numeric(0),
    description = character(0),
    total_species = numeric(0),
    native_species = numeric(0),
    non_native_species = numeric(0),
    total_mean_c = numeric(0),
    native_mean_c = numeric(0)
  )

  if (!is.data.frame(database)) {
    message(
      "database must be a data frame obtained from the universalFQA.org website. Type ?download_database for help."
    )
    return(invisible(bad_df))
  }

  if (ncol(database) == 0) {
    message(
      "database must be a dataframe obtained from the universalFQA.org website. Type ?download_database for help."
    )
    return(invisible(bad_df))
  }

  if (ncol(database) == 1) {
    new <- rbind(names(database),
                 database)

    database <- separate(
      new,
      col = 1,
      sep = ",",
      into = paste0("V", 1:9),
      fill = "right",
      extra = "merge"
    )
  }

  if (!("Total Species:" %in% database[[1]])) {
    message(
      "database must be a data frame obtained from the universalFQA.org website. Type ?download_database for help."
    )
    return(invisible(bad_df))
  }

  sm <- database[1:9, 1:2]
  sm[1:3, 2] <- sm[1:3, 1]
  sm <- sm[-4,]

  wide <- sm |>
    pivot_wider(names_from = "V1",
                values_from = "V2") |>
    mutate(across(c(2, 4:8),
                  as.numeric))

  names(wide) <- c(
    "region",
    "year",
    "description",
    "total_species",
    "native_species",
    "non_native_species",
    "total_mean_c",
    "native_mean_c"
  )

  wide

}








