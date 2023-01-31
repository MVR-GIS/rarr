<!-- README.md is generated from README.Rmd. Please edit that file -->

<img src="man/figures/kitten-roar4-2.jpg" width=250 align="right" />

# rarr

An `R` Package for producing Risk Analysis Reports

## Package Status

[![Maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle)
[![Project Status: Active The project has reached a stable, usable state
and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![packageversion](https://img.shields.io/badge/Package%20version-0.1.2-orange.svg?style=flat-square)](commits/master)
[![Last-changedate](https://img.shields.io/badge/last%20change-2023--01--31-yellowgreen.svg)](/commits/master)
[![Licence](https://img.shields.io/badge/licence-CC0-blue.svg)](http://choosealicense.com/licenses/cc0-1.0/)

## Description

<img src="man/figures/r_logo.png" width=75 align="left" />

This package contains a set of functions that are used to help produce a
Risk Analysis Report. These functions help automate and standardize
report production using the [`bookdown`
package](https://bookdown.org/yihui/bookdown/). These functions can be
grouped into three broad categories.

-   Access Data - These functions are used to extract data from USACE
    enterprise databases where the data is being entered and maintained
    by risk managers.
-   Format Pages - These functions are used to programmatically create
    report links and headers.
-   Produce Figures - These functions are used to create figures needed for risk reporting.

<img src="man/figures/HDQLO-03_h120.jpg" width=125 align="right" />

## Funding

Funding for development and maintenance of `rarr` has been
provided by the following US Army Corps of Engineers (USACE) programs:

-   [Brandon Road Interbasin Project
    (BRIP)](https://www.mvr.usace.army.mil/Missions/Environmental-Stewardship/BR-Interbasin-Project/)

------------------------------------------------------------------------

## Latest Updates

Check out the [News](news/index.html) for details on the latest updates.

------------------------------------------------------------------------

## Authors

-   [Michael Dougherty](mailto:Michael.P.Dougherty@usace.army.mil),
    Geographer, Rock Island District, U.S. Army Corps of Engineers
    <a itemprop="sameAs" content="https://orcid.org/0000-0002-1465-5927" href="https://orcid.org/0000-0002-1465-5927" target="orcid.widget" rel="me noopener noreferrer" style="vertical-align:top;">
    <img src="https://orcid.org/sites/default/files/images/orcid_16x16.png" style="width:1em;margin-right:.5em;" alt="ORCID iD icon">https://orcid.org/0000-0002-1465-5927</a>
-   [Barrie Chileen Martinez](mailto:Barrie.V.Chileen@usace.army.mil),
    Geographer, Rock Island District, U.S. Army Corps of Engineers
    <a itemprop="sameAs" content="https://orcid.org/0000-0002-6960-8167" href="https://orcid.org/0000-0002-6960-8167" target="orcid.widget" rel="me noopener noreferrer" style="vertical-align:top;">
    <img src="https://orcid.org/sites/default/files/images/orcid_16x16.png" style="width:1em;margin-right:.5em;" alt="ORCID iD icon">https://orcid.org/0000-0002-6960-8167</a>

------------------------------------------------------------------------

## Install

To install the `rarr` package, install from GitHub using the `remotes`
package:

    remotes::install_github(repo = "MVR-GIS/rarr")

## URL

For more information on `rarr` and its usage, access the package website here:
https://mvr-gis.github.io/rarr/

## Bug Reports

If you find any bugs using `rarr`, please open an
[issue](https://github.com/MVR-GIS/rarr/issues).
