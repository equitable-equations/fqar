# fqar 0.4.2

* Additional improvements for API failures

# fqar 0.4.1

* Fixed non-ascii character in the chicago data set

* Fixed bug that caused progress bars to appear in non-interactive calls

* Improved responses to API failure

# fqar 0.4.0

## New features

* New `transect_subplot_inventories` function for extracting species data from quadrat-level data in transect inventories.

* New function `transect_list_inventory` for extracting multiple transect-level species inventories simultaneously.

## Other improvements

* Improvements to `assessment_cooccurrence` and `assessment_cooccurrence_summary` which now treat species with the same name but different C-values as distinct.

# fqar 0.3.0

## New features

* New functions for extracting species information from databases: `species_acronym`, `species_c`, `species_common_name`, `species_phys`, and `species_w`.
* New functions extract information from databases: `database_glance` and `database_inventory`. 
* New tools for analyzing species co-occurrence: `assessment_cooccurrence`, `assessment_cooccurrence_summary`, `species_profile`, and `species_profile_plot`.

## Other improvements

* memoization for all `download\_*` functions, which generally run slowly due to limitations of the [universalfqa.org](https://universalfqa.org/) website.
* all data frame produced now have syntactic column names (for instance, `total_mean_c` instead of `Total Mean C`).


# fqar 0.2.1

* Major updates and better documentation
* Added a NEWS.md file to track changes to the package

