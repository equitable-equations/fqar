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

Floristic Quality Assessment (FQA) is a standardized method for rating the ecological value of natural areas based on the plant species found within them [@spyreas2015users]. Each species considered native to a particular region is assigned a *coefficient of conservatism*, C, on a scale of 0-10 by experts in local flora. Larger values of C correspond to species that tend to be found in undegraded sites, while lower values indicate species that are more tolerant to human impacts [@bauer]. An inventory of the site in question is conducted, and the average of the C-values found there is computed. This *native mean C-value*, sometimes weighted by the total number of plant species identified to give the so-called *floristic quality index* [@bowles2006testing], is frequently used by land managers and other agents to quantify an area's state of conservancy [@zinnen]. 

In recent years, it has become increasingly standard for practitioners to upload their floristic quality assessments to a central repository, [universalfqa.org](https://universalfqa.org/) [@freyman2016universal], which already includes tens of thousands of assessments from over one hundred floristic quality databases. This large public data cache represents a potentially invaluable resource for quantitative ecologists, though it has so far gone largely unexplored due to a lack of both technical tools for inteacting programatically with the repository and statistical methods for analyzing the floristic quality data housed there. 

`fqar` is an R [@rcore] package which facilitates the analysis of occurrence and co-occurrence of plant taxa at the regional level. Pulling data on-demand from [universalfqa.org](https://universalfqa.org/), it provides both organizational tools for handling the disparate sorts of data housed there and statistical ones for drawing novel conclusions from that data. 

# Statement of need

The [universalfqa.org](https://universalfqa.org/) website is designed primarily to aid field botanists, who can rapidly obtain floristic quality assessment results simply by uploading their site inventories to the repository. While it facilitates storage and sharing, [universalfqa.org](https://universalfqa.org/) does not provide users any tools for make constructive use of its data beyond simple viewing and downloading of individual assessments. This is in keeping with the original motivation for floristic quality assessment: to aid land managers in making conservation decisions. 

The `fqar` package enables analysis with a wider lens, allowing users to consider database-wide records of plant taxa or characteristics. By considering entire collections of assessments simultaneously, ecologists may gain insights into floristic quality assessment as well as the various plant species it tracks. Among the wide range of questions made answerable by `fqar` are the following:

- what is the co-occurrence profile of a given species of interest? What other plants (or types of plants) is it identified alongside most frequently?

- which species in a given database might be misclassified? Based on their co-occurrence profile, might some be more or less conservative than previously thought?

- what species are most commonly identified in certain regions? Which have been reported seldom or not at all?

- which non-native species have become widespread in particular regions? Do those species tend to be symptomatic of degraded areas, or do they tend to coexist alongside more conservative native plants?

There is currently great need in the ecological community to validate and potentially refine the floristic quality assessment methodology [@spyreas2019floristic]. Because C-values, the metric on which FQA is ultimately based, are assigned based on the experience of small numbers of local experts, there are inevitable inconsistencies and irregularities which only a larger-scale reconsideration can address. Thus far the community has only been able to take preliminary or ad hoc steps in that direction [@matthews2015null], [@bourdaghs2006properties]. The `fqar` package will allow for a more deep, targeted analysis.

# Typical workflow

Analysts using `fqar` will typically download and reformat the assessments of interest before using functions like `assessment_cooccurrence_summary` to analyze the data. The following workflow does just this for the *Flora of the Chicago Region* database, an updated version of the original floristic quality manual [@wilhelm2017flora]. Depending on the needs of the specific user, such analysis can be restricted to particular practitioners, organizations, or locations, or redirected entirely along the lines described in the previous section.

First, download all public assessments in the desired database and reshape them into a standard format:

```r
library(fqar)
chicago_fqas <- download_assessment_list(database_id = 80)
chicago_invs <- assessment_list_inventory(chicago_fqas)
```

The output of the former command is a list of data frames in the original format provided by [universalfqa.org](https://universalfqa.org/). Each of these data frames includes several different sorts of information: species-level observations, summary statistics, and metadata. The second command isolates the species inventories and stores them in a tidy format.  

Next, extract co-occurrence information from this collection of species inventories:

```r
chicago_cooccurrence <- assessment_cooccurrences(chicago_invs)
````

`fqar` provides tools for both quantitative and visual descriptions of the co-occurrence profile of given species. 

```r
species_profile(chicago_invs, species = "Fragaria virginiana", native = TRUE) # a data frame
species_profile_plot(chicago_invs, species = "Fragaria virginiana", native = TRUE) # a visualization
```

<img src="strawberry_plot.png" align="center"/>  

Here we see that *Fragaria virginiana*, the wild strawberry, is listed with C $=0$ in the Chicago database but co-occurs with a wide variety of more conservative species. In particular, it has been found with 10's more frequently than it has with other 0's. 

Summary co-occurrence information for the entire database can be extracted with `assessment_cooccurrences_summary`, which gives a complete listing of all observed species and their co-occurring mean C-values.

```r
chicago_summary <- assessment_cooccurrences(chicago_invs)
```

The data generated by functions like these will be invaluable in the validation and refinement of floristic quality assessment.

# Availability

The `fqar` package is freely available via the Comprehensive R Archive Network (CRAN). 

`install.packages("fqar")`

Alternatively, the latest developmental version can be installed directly from GitHub:

`devtools::install_github("equitable-equations/fqar")`

Thorough documentation is provided. A long-form vignette gives a birds-eye overview of the package's functionality while help files for individual functions provide guidance on particular data analysis tasks. 

# Acknowledgements

The authors wish to thanks Glenn Adelson, Ph.D  (Lake Forest College) and Justin Thomas, M.Sc ([NatureCITE](https://www.naturecite.org/)) for their insight into floristic quality assessment. 

# References

