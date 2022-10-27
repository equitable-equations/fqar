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
#'    \item total species (numeric)
#'    \item native species (numeric)
#'    \item non-native species (numeric)
#'    \item total mean C (numeric)
#'    \item native mean C (numeric)
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


database_glance <- function(database){

  if (!is.data.frame(database)) {
    stop("database must be a data frame obtained from the universalFQA.org website. Type ?download_assessment for help.", call. = FALSE)
  }

  if (ncol(database) == 1) {

    new <- rbind(names(database), database)

    database <- separate(new,
                         col = 1,
                         sep = ",",
                         into = paste0("V", 1:9),
                         fill = "right",
                         extra = "merge")
  }

  if (!("Total Species:" %in% database[[1]])) {
    stop("database must be a data frame obtained from the universalFQA.org website. Type ?download_assessment for help.", call. = FALSE)
  }

  sm <- database[1:9, 1:2]
  sm[1:3, 2] <- sm[1:3, 1]
  sm <- sm[-4, ]

  wide <- sm |>
    pivot_wider(names_from = "V1",
                values_from = "V2") |>
    mutate(across(c(2, 4:8), as.numeric))

  names(wide) <- c("region",
                   "year",
                   "description",
                   "total species",
                   "native species",
                   "non-native species",
                   "total mean C",
                   "native mean C")
  wide
}








