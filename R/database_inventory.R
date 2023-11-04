#' Obtain species details for a floristic quality database
#'
#' \code{database_inventory()} returns a data frame of all plant species
#' included in a floristic quality database obtained from
#' \href{https://universalfqa.org/}{universalfqa.org}.
#'
#' @param database A database downloaded from
#'   \href{https://universalfqa.org/}{universalfqa.org} either manually or using
#'   \code{\link[=download_database]{download_database()}}.

#' @return A data frame with 9 columns:
#' \itemize{
#'    \item scientific_name (character)
#'    \item family (character)
#'    \item acronym (character)
#'    \item nativity (character)
#'    \item c (numeric)
#'    \item w (numeric)
#'    \item physiognomy (character)
#'    \item duration (character)
#'    \item common_name (character)
#' }
#'
#' @import dplyr tidyr
#' @importFrom rlang .data
#'
#' @examples
#' # While database_glance can be used with a .csv file downloaded
#' # manually from the universal FQA website, it is most typically used
#' # in combination with download_database().
#'
#' chicago_db <- download_database(database_id = 1)
#' chicago_species <- database_inventory(chicago_db)
#'
#' @export

database_inventory <- function(database) {

  bad_df <- data.frame(
    scientific_name = character(0),
    family = character(0),
    acronym = character(0),
    nativity = character(0),
    c = numeric(0),
    w = numeric(0),
    physiognomy = character(0),
    duration = character(0),
    common_name = character(0)
  )

  if (!is.data.frame(database)) {
    message("database must be a data frame obtained from the universalFQA.org website. Type ?download_database for help.")
    return(invisible(bad_df))
  }

  if (ncol(database) == 0){
    message("database must be a data frame obtained from the universalFQA.org website. Type ?download_database for help.")
    return(invisible(bad_df))
  }

  if (ncol(database) == 1) {

    new <- rbind(names(database),
                 database)

    database <- separate(new,
                         col = 1,
                         sep = ",",
                         into = paste0("V", 1:9),
                         fill = "right",
                         extra = "merge")
  }

  if (!("Scientific Name" %in% database[[1]])) {
    message("database must be a data frame obtained from the universalFQA.org website. Type ?download_database for help.")
    return(invisible(bad_df))
  }


  inv <- database |>
    filter(row_number() > which(.data$V1 == "Scientific Name")) |>
    mutate(across(5:6, as.numeric))

  names(inv) <- c(
    "scientific_name",
    "family",
    "acronym",
    "nativity",
    "c",
    "w",
    "physiognomy",
    "duration",
    "common_name"
  )

  inv

}





