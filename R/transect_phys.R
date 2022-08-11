#' Obtain physiognomy information a given floristic quality transect assessment
#'
#' @param data_set a data frame downloaded from Universal FQA using download_transect() or other similar function
#' @return  A data frame with 6 columns:
#' \itemize{
#'    \item Physiognomy (character)
#'    \item Frequency (numeric)
#'    \item Coverage (numeric)
#'    \item Relative Frequency % (numeric)
#'    \item Relative Coverage % (numeric)
#'    \item Relative Importance Value (numeric)
#' }
#'
#' @import dplyr tidyr
#' @importFrom rlang .data

#' @examples
#' \dontrun{
#' ## while transect_phys can be used with a .csv file downloaded manually from the universal FQA website, it is most typically used in combination with \code{\link{download_transect}}:
#'
#' tyler <- download_transect(6352)
#' transect_phys(tyler)
#' }
#' @export

transect_phys <- function(data_set) {

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
                         into = paste0("V", 1:14),
                         fill = "right")
  }

  data_set <- na_if(data_set, "n/a")
  data_set <- na_if(data_set, "")

  start_row <- 2 + which(data_set$V1 == "Physiognomic Relative Importance Values:")
  end_row <- -2 + which(data_set$V1 == "Species Relative Importance Values:")
  if (end_row < start_row) {
    stop("No physiognometric data found")
  }
  phys <- data_set[start_row:end_row, 1:6]

  names(phys) <- data_set[start_row - 1, 1:6]

  phys |>  mutate(across(2:6, as.double))

}

