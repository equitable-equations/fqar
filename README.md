# fqar 

<img src="man/figures/logo.png" align="right" height="138" />

  <!-- badges: start -->
  [![R-CMD-check](https://github.com/equitable-equations/fqar/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/equitable-equations/fqar/actions/workflows/R-CMD-check.yaml)
  <!-- badges: end -->
  
Floristic quality assessment (FQA) is a standardized method for rating the ecological value of plant communities based on the native species found there. The ${\tt fqar}$ package provides tools to download and analyze floristic quality assessments from universalfqa.org.

## Installation

The development version can be installed from [GitHub](https://github.com/equitable-equations/fqar).

```{r install}
# Install development version from GitHub: 
devtools::install_github("equitable-equations/fqar")
```

## Usage 

The ${\tt fqar}$ package consists of three categories of functions: indexing, downloading, and tidying functions. ${\tt fqar}$ also includes two sample data sets.

### Indexing functions

```{r indexing}
# download a list of all fqa databases:
databases <- index_fqa_databases()

# download a list of all assessments in a specific database:
chicago_fqas <- index_fqa_assessments(database_id = 149) 

# download a list of all transect assessments in a specific database:
chicago_transects <- index_fqa_transects(database_id = 149)
```

### Downloading functions

Floristic quality assessments can be downloaded individually by ID number or collectively using ${\tt dplyr::filter}$ syntax.

```{r downloading}
# download a single assessment:
woodland <- download_assessment(assessment_id = 25640)

# download multiple assessments:
mcdonald_fqas <- download_assessment_list(database_id = 149, 
                                          site == "McDonald Woods")
```

${\tt fqar}$ also provides functions for downloading transect assessments.

```{r downloading2}
# download a single transect assessment:
rock_garden <- download_transect(transect_id = 6875)

# download multiple transect assessments:
lord_fqas <- download_transect_list(database = 63,
                                    practitioner == "Sam Lord")
```

Unfortunately, the universalfqa.org server is often slow, and downloads (especially for transect assessments) may take some time. 

### Tidying functions

Data sets obtained from universalfqa.org are quite messy. ${\tt fqar}$ provides tools for converting such sets into a more convenient tidy format.

```{r tidying}
# obtain a data frame with species data for a downloaded assessment:
woodland_species <- assessment_inventory(woodland)

# obtain a data frame with summary information for a downloaded assessment:
woodland_summary <- assessment_glance(woodland)

# obtain a data frame with summary information for multiple downloaded assessments:
mcdonald_summary <- assessment_list_glance(mcdonald_fqas)
```

Similar functions are provided for handling transect assessments. For those sets, physiognometric information can also be extracted.

```{r tidying2}
# obtain a data frame with species data for a downloaded transect assessment:
survey_species <- transect_inventory(rock_garden)

# obtain a data frame with physiognometric data for a downloaded transect assessment:
survey_phys <- transect_phys(rock_garden)

# obtain a data frame with summary information for a downloaded transect assessment:
rock_garden_summary  <- transect_glance(rock_garden)

# obtain a data frame with summary information for multiple downloaded transect assessments:
lord_summary <- transect_list_glance(lord_fqas)
```

## Learn More 
* Read the ${\tt fqar}$ [vignette](https://github.com/equitable-equations/fqar/blob/main/vignettes/fqar.Rmd) to learn how to download and analyze FQAs with fqar.
* View the help files of any function in the ${\tt fqar}$ package for more examples. 
