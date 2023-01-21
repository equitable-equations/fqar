# fqar 0.3.0

## New features

* New functions for extracting species information from databases: `species_acronym`, `species_c`, `species_common_name`, `species_phys`, and `species_w`.
* New functions extract information from databases: `database_glance` and `database_inventory`. 
* New tools for analyzing species co-occurrence: `assessment_cooccurrence`, `assessment_cooccurrence_summary`, `species_profile`, and `species_profile_plot`.

## Other improvements

* memoization for all `download\_*` functions, which generally run slowly due to limitations of the [universalfqa.org](https://universalfqa.org/) website.
* all data frame produced now have syntactic column names ( for instance, `total_mean_c` instead of `Total Mean C`).


# fqar 0.2.1

* Major updates and better documentation
* Added a NEWS.md file to track changes to the package

