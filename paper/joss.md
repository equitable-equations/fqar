---
title: 'fqar: An R package for working with floristic quality assessment data'
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

Floristic Quality Assessment (FQA) is a standardized method for assessing the ecological value of a natural area based on the plant species found there (ref). Each species considered native to the region is assigned a *coefficient of conservatism*, C, on a scale of 0-10 by experts in local flora, with larger values corresponding to species that tend to be found in undegraded sites. A site inventory is conducted, and the average of the C-values found there is computed. This *mean-C value* is frequently used by land managers and other agents to quantify an area's state of conservancy (ref). 

Although floristic quality assessment dates back to the 1994 publication of (ref), its use has expanded significantly in recent years, in large part due to the central data repository [universalfqa.org](https://universalfqa.org/) (ref), where practitioners can easily upload site inventories, select an appropriate species database, and receive numeric assessments in .csv format. As of September, 2022, there were over xxx public assessments from more than 70 databases accessible via the site, covering much of the continental United States and parts of Canada.

The `fqar` packages provides tools for downloading and extracting species inventories and assessment-level statistics from downloaded reports, both individually and in batches.

# Statement of need

The [universalfqa.org](https://universalfqa.org/) website is calibrated for practitioners in the field rather than data analysts at their desks. It facilitates the recording, storing, and publicizing of individual floristic quality assessments and performs calculations of the statistical measures most often cited by land managers and conservation organizations in their reporting, including mean-C. Still, the .csv reports it generates are poorly-suited for data analysis for any number of technical reasons, including the following:

- The floristic quality assessments it exports include multiple sorts of observations, including assessment-level data like location and weather, raw species inventories, and summary statistics like mean C, all in a single spreadsheet.
- Descriptors for the various sorts of observations sometimes appear as cell entries, sometimes as header rows, and sometimes not at all
- Individual cells are formatted inconsistently


The outputs of these functions are all tibbles in tidy format (ref), making them far more convenient for data analysis.

# Availability

The `fqar` package is freely available via the Comprehensive R Archive Network (CRAN). 

`install.packages("fqar")`

Alternatively, the latest developmental version can be installed directly from GitHub:

`devtools::install_github("equitable-equations/fqar")`

Thorough documentation is provided. A long-form vignette gives a birds-eye overview of the package's functionality while help files for individual functions provide guidance on particular data analysis tasks. 

# Citations

Citations to entries in paper.bib should be in
[rMarkdown](http://rmarkdown.rstudio.com/authoring_bibliographies_and_citations.html)
format.

If you want to cite a software repository URL (e.g. something on GitHub without a preferred
citation) then you can do it with the example BibTeX entry below for @fidgit.

For a quick reference, the following citation commands can be used:
- `@author:2001`  ->  "Author et al. (2001)"
- `[@author:2001]` -> "(Author et al., 2001)"
- `[@author1:2001; @author2:2001]` -> "(Author1 et al., 2001; Author2 et al., 2002)"

[@spyreas2015users]

# Figures

Figures can be included like this:
![Caption for example figure.\label{fig:example}](figure.png)
and referenced from text using \autoref{fig:example}.

Figure sizes can be customized by adding an optional second parameter:
![Caption for example figure.](figure.png){ width=20% }

# Acknowledgements

The authors wish to thanks Glenn Adelson, Ph.D  (Lake Forest College) and Justin Thomas, M.Sc (NatureCITE) for their insight into floristic quality assessment. 

# References

