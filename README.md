# fqar
# fqar <img src="man/figures/logo.png" align="right" height="138" />

Floristic quality assessments (FQA's) are a method of assessing the quality of ecological communities and other natural areas. The ${\tt fqar}$ package provides tools to analyze and download FQA’s from www.universalfqa.org.

## Installation

The development version can be installed from [GitHub](https://github.com/flavorcat/fqar2).

```{r install}
# Install development version from GitHub 
devtools::install_github("flavorcat/fqar2")
```

## Usage 

The ${\tt fqar}$ package consists of three categories of functions: indexing, downloading, and tidying functions. ${\tt fqar}$ also includes two sample data sets.

### Indexing functions: 

```{r indexing}
# to download a list of all fqa databases 
databases <- download_fqa_databases()

# to download a list of all assessments in a specific database
chicago_fqas <- download_fqa_assessments(database_id = 149) 

# to download a list of all transects in a specific database
chicago_transects <- download_fqa_transects(database_id = 149)
```

### Downloading functions:

```{r downloading}
# to download a single assessment
woodland <- download_assessment(assessment_id = 25640)

# to download multiple assessments
mcdonald_fqas <- download_assessment_list(database = 149,
                                          site == "McDonald Woods")
```

The same can be done for transect-level data 

```{r downloading2}
survey <- download_transect(transect_id = 6875)
lord_fqas <- download_transect_list(database = 63,
                                    practitioner == "Sam Lord")
```

### Tidying functions:

```{r tidying}
# to obtain a data frame of species data from an assessment 

woodland_species <- assessment_inventory(woodland)

# to obtain a data frame of summary information from an assessment 

woodland_summary <- assessment_glance(woodland)

# to obtain a data frame of summary information from multiple assessments 

mcdonald_summary <- assessment_list_glance(mcdonald_fqas)
```

The same can be done for transect-level data

```{r tidying2}
survey <- download_transect(transect_id = 6875)
survey_species <- transect_inventory(survey)
survey_summary  <- transect_glance(survey)
lord_summary <- transect_list_glance(lord_fqas)
```

In addition, transect-level data includes physiognometric data that can be isolated 

```{r tidying3}
# to obtain physiognometric data from a transect in a data frame
survey_phys <- transect_phys(survey)
```

More examples can be found in the [vignette](https://github.com/flavorcat/fqar2/blob/main/vignettes/fqar.Rmd).

## Learn More 
* Read the ${\tt fqar}$ [vignette](https://github.com/flavorcat/fqar2/blob/main/vignettes/fqar.Rmd) to learn how to download and analyze FQA’s with fqar.
* View the help files of any function in *fqar* for more examples 
