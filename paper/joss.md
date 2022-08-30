---
title: 'fqar: An R package for analyzing floristic quality assessment data'
tags:
  - R
  - ecology
  - floristic quality assessment
authors:
  - name: Andrew Gard
    orcid: 0000-0003-4434-0755
    equal-contrib: false
    affiliation: 1
    corresponding: true 
  - name: Alexia Myers
    equal-contrib: false 
    affiliation: 1
affiliations:
 - name: Lake Forest College, Lake Forest IL, USA
   index: 1
date: 18 August 2022
bibliography: fqar_refs.bib

---

# Summary

Floristic Quality Assessment (FQA) is a standardized method for assessing the ecological value of natural areas based on the plant species found within them [@spyreas2015users]. Each species considered native to a particular region is assigned a *coefficient of conservatism*, C, on a scale of 0-10 by experts in local flora. Larger values of C correspond with species that tend to be found in undegraded sites, while lower values indicate species that are more tolerant to human impacts. A site inventory is conducted, and the average of the C-values found there is computed. This *native mean-C value*, sometimes weighted by the total number of plant species identified to give the so-called *floristic quality index* [@bowles2006testing], is frequently used by land managers and other agents to quantify an area's state of conservancy [@zinnen]. 

Although floristic quality assessment dates back to the  1970s [@wilhelm1977], its use has expanded significantly in recent years, in large part due to the creation of a central data repository, [universalfqa.org](https://universalfqa.org/) [@freyman2016universal], where practitioners can easily upload site inventories, select appropriate species databases, and receive quantitative assessments in .csv format. As of September, 2022, the site provided access to over xxx public assessments from more than 70 databases, covering much of the continental United States and parts of Canada. For instance, see [@oldham1995floristic] for Ontario, Canada flora and [@rericha] for flora of the Chicago, USA region.

The `fqar` packages provides tools for downloading and analyzing floristic quality assessment data using R [@rcore].

# Statement of need

The [universalfqa.org](https://universalfqa.org/) website is calibrated for practitioners in the field rather than data analysts at their desks. It facilitates the recording, storing, and publicizing of individual floristic quality assessments and performs calculations of the statistical measures most often cited by land managers and conservation organizations in their reporting, including native mean-C. Still, the reports it generates are poorly-suited for data analysis for a number of technical reasons, including the following:

- Exported .csv files include multiple sorts of observations, including assessment-level data like location and weather, raw species inventories, and summary statistics like mean C, all in a single spreadsheet.
- Descriptors for the various sorts of observations sometimes appear as cell entries, sometimes as header rows, and sometimes not at all.
- Individual cells are formatted inconsistently.

The `fqar` package addresses these and other technical difficulties. 

# Typical workflow

Available databases of plant species and their associated C-values for various regions can be viewed and downloaded using a family of indexing functions. For instance, the following code produces a data frame listing all public assessments that draw the 2015 Missouri database [@ladd2015ecological]:

```r 
library(fqar)
missouri_assessments_available <- index_fqa_assessments(database_id = 63)
```

A summary of the `database_id`s assigned by  [universalfqa.org](https://universalfqa.org/) can be obtained with the `index_fqa_databases()` function.

An analyst can download all available assessments in a given database or specify a narrower subset by practitioner, site, date, or other criteria using `dplyr` [@Wickham:2022vf] syntax. For instance, the following code downloads all assessments done by Justin Thomas with the Missouri database.

```r
thomas_fqas <- download_assessment_list(database_id = 63,
                                        practitioner == "Justin Thomas")
```

The output of this commands is a list of data frames in the raw format provided by [universalfqa.org](https://universalfqa.org/). Summary data can be obtained in tidy format [@JSSv059i10] with `fqar::assessment_list_glance()`:

```r
thomas_tidy <- assessment_list_glance(thomas_fqas)
```

Species inventories for individual assessments can be extracted (again in tidy format) with `fqar::assessment_inventory()`.

# Availability

The `fqar` package is freely available via the Comprehensive R Archive Network (CRAN). 

`install.packages("fqar")`

Alternatively, the latest developmental version can be installed directly from GitHub:

`devtools::install_github("equitable-equations/fqar")`

Thorough documentation is provided. A long-form vignette gives a birds-eye overview of the package's functionality while help files for individual functions provide guidance on particular data analysis tasks. 

# Acknowledgements

The authors wish to thanks Glenn Adelson, Ph.D  (Lake Forest College) and Justin Thomas, M.Sc ([NatureCITE](https://www.naturecite.org/)) for their insight into floristic quality assessment. 

# References

