#' Physiognomy of a species in a specified database
#'
#' \code{species_phys()} accepts a species and a database inventory and returns the
#' physiognomy of that species. Either a numeric database ID from
#' \href{https://universalfqa.org/}{universalfqa.org} or a homemade inventory
#' with the same format may be specified.
#'
#' @param species The scientific name of the plant species of interest
#' @param database_id ID number of an existing database on
#'   \href{https://universalfqa.org/}{universalfqa.org}. Use
#'   \code{\link[=index_fqa_databases]{index_fqa_databases()}} to see a list of
#'   all such databases.
#' @param database_inventory An inventory of species having the same form as one
#'   created using \code{\link[=database_inventory]{database_inventory()}}, that
#'   is, a data frame with 9 columns:
#'   \itemize{
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
#' @return The physiognomy of the given species within the given database
#'
#' @import dplyr
#' @importFrom rlang .data
#'
#' @examples
#' species_phys("Anemone canadensis", database_id = 149)
#'
#' @export


species_phys <-
  function(species,
           database_id = NULL,
           database_inventory = NULL) {
    if (is.null(database_id) & is.null(database_inventory)) {
      stop("Either database_id or database_inventory must be specified.",
           call. = FALSE)
    }

    if (!is.null(database_id) & !is.null(database_inventory)) {
      stop("database_id or database_inventory cannot both be specified.",
           call. = FALSE)
    }

    if (!is.null(database_id)) {
      db <- suppressMessages(download_database(database_id))

      if (nrow(db) == 0){
        message("No inventory data returned by universalFQA.org.")
        return(invisible(NA))
      }

      database_inventory <- database_inventory(db)
    }

    inv_list <-
      list(database_inventory) # To check if the specified inventory is valid.
    if (!is_inventory_list(inv_list)) {
      stop(
        "database_inventory must be a species inventory in the format provided by database_inventory().",
        call. = FALSE
      )
    }

    if (!(species %in% database_inventory$scientific_name)) {
      message("Species not found in specified database.")
      return(NA)
    }

    species_row <- database_inventory |>
      dplyr::filter(.data$scientific_name == species)

    phys <- species_row$physiognomy[1]

    phys
  }







