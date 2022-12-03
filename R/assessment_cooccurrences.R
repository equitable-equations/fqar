#' Generate a species co-occurrence matrix from assessment inventories
#'
#' \code{assessment_coccurrences()} accepts a list of species inventories
#' downloaded from \href{https://universalfqa.org/}{universalfqa.org} and
#' returns a complete listing of all co-occurrences. Repeated co-occurrences
#' across multiple assessments are included, but self co-occurrences are not,
#' allowing for meaningful summary statistics to be computed.
#'
#' @param inventory_list A list of site inventories having the format of
#' \code{\link[=assessment_list_inventory]{assessment_list_inventory()}}
#'
#' @return A data frame with 12 columns:
#' \itemize{
#' \item target_species (character)
#' \item target_species_c (numeric)
#' \item target_species_nativity (character)
#' \item cospecies_scientific_name (character)
#' \item cospecies_family (character)
#' \item cospecies_acronym (character)
#' \item cospecies_nativity (character)
#' \item cospecies_c (numeric)
#' \item cospecies_w (numeric)
#' \item cospecies_physiognomy (character)
#' \item cospecies_duration (character)
#' \item cospecies_common_name (character)
#' }
#'
#' @import dplyr
#' @importFrom rlang .data
#'
#' @examples
#' # assessment_cooccurrences is best used in combination with
#' # download_assessment_list() and assessment_list_inventory().
#'
#' \donttest{
#' ontario <- download_assessment_list(database = 2)
#' ontario_invs <- assessment_list_inventory(ontario)
#' ontario_cooccurrences <- assessment_cooccurrences(ontario_invs)
#' }
#'
#' @export


# Also must consider problematic lists with incorrect structure, both here and in testing.

assessment_cooccurrences <- function(inventory_list){

  if (!is_inventory_list(inventory_list)){
    stop("assessment_list must be a list of dataframes obtained from universalFQA.org. Type ?download_assessment_list for help.", call. = FALSE)
  }

  species <- character(0)
  species_c <- character(0)
  species_nativity <- character(0)

  for (i in seq_along(inventory_list)){
    species <- c(species,
                 inventory_list[[i]]$scientific_name)
    species_c <- c(species_c,
                   inventory_list[[i]]$c)
    species_nativity <- c(species_nativity,
                          inventory_list[[i]]$nativity)
  } # to keep track of target species, c-value, and nativity

  species_df <- data.frame(species, species_c, species_nativity)
  species_df <- unique(species_df)

  cooccur_df <- data.frame(target_species = character(),
                           target_species_c = numeric(),
                           target_species_nativity = character(),
                           cospecies_scientific_name = character(),
                           cospecies_family = character(),
                           cospecies_acronym = character(),
                           cospecies_nativity = character(),
                           cospecies_c = numeric(),
                           cospecies_w = numeric(),
                           cospecies_physiognomy = character(),
                           cospecies_duration = character(),
                           cospecies_common_name = character()
  ) # initialize data frame

  cooccur_list <- list()

  for (sp in seq_along(species_df$species)){
    included <- vector("logical")
    for (inventory in seq_along(inventory_list)){
      included[inventory] <-
        (species_df$species[sp] %in% inventory_list[[inventory]]$scientific_name)
    } # gives a logical vector indicating which inventories include the given species

    short_list <- inventory_list[included]
    short_list_combined <- bind_rows(short_list)

    short_list_combined <- dplyr::filter(short_list_combined,
                                         .data$scientific_name != species_df$species[sp]) # ignoring self-cooccurrence

    short_list_combined <- cbind(rep(species_df$species[sp],
                                     nrow(short_list_combined)),
                                 rep(species_df$species_c[sp],
                                     nrow(short_list_combined)),
                                 rep(species_df$species_nativity[sp],
                                     nrow(short_list_combined)),
                                 short_list_combined) # adds species name, c and nativity

    cooccur_list[[sp]] <- short_list_combined
  }

  cooccur_df <- dplyr::bind_rows(cooccur_list)
  names(cooccur_df) <- c("target_species",
                         "target_species_c",
                         "target_species_nativity",
                         "cospecies_scientific_name",
                         "cospecies_family",
                         "cospecies_acronym",
                         "cospecies_nativity",
                         "cospecies_c",
                         "cospecies_w",
                         "cospecies_physiognomy",
                         "cospecies_duration",
                         "cospecies_common_name"
  )

  cooccur_df |>
    dplyr::arrange(.data$target_species) |>
    dplyr::mutate(target_species_c = as.numeric(.data$target_species_c))

}
