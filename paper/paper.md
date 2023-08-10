---
title: 'The fqar package: R tools for analyzing floristic quality assessment data'
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
  - name: Irene Luwabelwa
    equal-contrib: false 
    affiliation: 1    
affiliations:
 - name: Lake Forest College, Lake Forest IL, USA
   index: 1
date: 18 August 2023
bibliography: fqar_refs.bib

---

# Summary

Floristic Quality Assessment (FQA) is a standardized method for rating the ecological value of natural areas based on the plant species found within them [@spyreas2015users]. Each species considered native to a particular region is assigned a *coefficient of conservatism*, C, on a scale of 0-10 by experts in local flora. Larger values of C correspond to species that tend to be found in undegraded sites, while lower values indicate species that are more tolerant to human impacts. An inventory of the site in question is conducted, and the average of the C-values found there is computed. This *native mean-C value*, sometimes weighted by the total number of plant species identified to give the so-called *floristic quality index* [@bowles2006testing], is frequently used by land managers and other agents to quantify an area's state of conservancy [@zinnen]. 

In recent years it has become increasingly standard for practitioners to upload their floristic quality assessments to a central repository, [universalfqa.org](https://universalfqa.org/) [@freyman2016universal], which already includes tens of thousands of assessments from over one hundred floristic quality databases. This large public database represents a new domain for quantitative ecology which so far has been largely unexplored, due to a lack of both technical tools for inteacting programatically with the repository and statistical methods for analyzing the floristic quality data housed there. 

The `fqar` R [@rcore] package facilitates analysis of occurrence and co-occurrence of plant taxa at the regional level. Pulling data on-demand from [universalfqa.org](https://universalfqa.org/), it provides both organizational tools for handling the disparate sorts of data housed there and statistical ones for drawing novel conclusions from that data. 

# Statement of need

While [universalfqa.org](https://universalfqa.org/) represents a valuable central repository for floristic quality assessments, it does not provide users any tools to make constructive use of that data beyond simple viewing and downloading of individual assessments. This is in keeping with the original motivation for floristic quality assessment: to aid land managers in making conservation decisions. 

The `fqar` package enables analysis with a wider lens, allowing users to consider database-wide records of plant taxa or characteristics. By considering entire collections of assessments simultaneously, ecologists may gain insights into floristic quality assessment as well as the plant species it tracks. Among the wide variety of questions made answerable by `fqar` are the following:

- what is the co-occurrence profile of a given species of interest? What other plants (or types of plants) is it identified alongside most frequently?

- what species in a given database might be misclassified? Based on their co-occurrence profile, might some be more or less conservative than previously thought?

- what species are most commonly identified in certain regions? Which have been reported seldom or not at all?

- which non-native species have become widespread in particular regions? Do those species tend to be symptomatic of degraded areas, or can they coexist alongside conservative native plants?

There is currently great need in the ecological community to validate and potentially refine the floristic quality assessment methodology (refs). Because C-values, the metric on which FQA is ultimately based, are assigned based on the experience of small numberes of local experts, there are inevitable inconsistencies and irregularities which only a larger-scale reconsideration can alleviate. Thus far the community has only been able to take preliminary or ad hoc steps in that direction (refs). The `fqar` package will allow for a deep, targeted analysis.

# Typical workflow

Users of `fqar` will typically download and reformat their assessments of interest before using functions like `assessment_cooccurrence_summary` to analyze the data. 

The analyst can download all available assessments in a given database or specify a narrower subset by practitioner, site, date, or other criteria using `dplyr` [@Wickham:2022vf] syntax. For instance, the following code downloads all assessments done by Justin Thomas using the Missouri database.

```r
library(fqar)
thomas_fqas <- download_assessment_list(database_id = 63,
                                        practitioner == "Justin Thomas")
```

The output of this commands is a list of data frames in the raw format provided by [universalfqa.org](https://universalfqa.org/). Summary data can be obtained in tidy format [@JSSv059i10] with `assessment_list_glance()`:

```r
thomas_tidy <- assessment_list_glance(thomas_fqas)
```

Users will then typically extract inventory-level species information for the purposes of cross-species co-occurrence analysis. 

```r
thomas_invs <- assessment_list_inventory(thomas_fqas)
thomas_cooccurrence <- assessment_cooccurrences(thomas_invs)
````

`fqar` provides tools for both quantitative and visual descriptions of the co-occurrence profile of given species. 

```r
species_profile_plot(thomas_invs, species = "Acer rubrum", native = TRUE)
```

# Availability

The `fqar` package is freely available via the Comprehensive R Archive Network (CRAN). 

`install.packages("fqar")`

Alternatively, the latest developmental version can be installed directly from GitHub:

`devtools::install_github("equitable-equations/fqar")`

Thorough documentation is provided. A long-form vignette gives a birds-eye overview of the package's functionality while help files for individual functions provide guidance on particular data analysis tasks. 

# Acknowledgements

The authors wish to thanks Glenn Adelson, Ph.D  (Lake Forest College) and Justin Thomas, M.Sc ([NatureCITE](https://www.naturecite.org/)) for their insight into floristic quality assessment. 

# References

