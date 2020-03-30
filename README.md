
<!-- README.md is generated from README.Rmd. Please edit that file -->

# reschola <a href='https://scholaempirica.github.io/reschola'><img src='man/figures/logo.png' align="right" height="139" /></a>

<!-- badges: start -->

[![Travis build
status](https://travis-ci.org/scholaempirica/reschola.svg?branch=master)](https://travis-ci.org/scholaempirica/reschola)
[![CRAN
status](https://www.r-pkg.org/badges/version/reschola)](https://CRAN.R-project.org/package=reschola)
![GitHub release (latest by date including
pre-releases)](https://img.shields.io/github/v/release/scholaempirica/reschola?include_prereleases)
[![Lifecycle:
maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
<!-- badges: end -->

The goal of reschola is to support the workflow for data analysis at
[Schola Empirica](http://scholaempirica.org) through a set of templates,
themes, utilities, and documentation. The vignettes for the package
document the Schola Empirica way of doing data analysis and provide
guidance and tips on tools and good practice.

## Installation

You can install the released version of reschola from
[Github](https://github.com) with:

``` r
remotes::install_github("scholaempirica/reschola", 
                         ref = remotes::github_release(),
                         build_vignettes = TRUE)
```

The current development version [Github](https://github.com) can be
installed with:

``` r
remotes::install_github("scholaempirica/reschola",
                         build_vignettes = TRUE))
```

If you are having trouble installing packages from sources, the binaries
of `reschola` are available in [the Schola `drat`
repository](https://scholaempirica.github.io/drat). This is a package
repository that can be used in the same way as CRAN, meaning you can use
`install.packages()` and if binaries are available, you don’t need
development tools to compile source packages.

You can install binaries from Schola `drat` like so:

``` r
options(repos = c(getOption("repos"), "scholaempirica" = "scholaempirica.github.io/drat"))
install.packages("reschola")
```

If you want to always have direct access to this `drat` repository like
you have to CRAN, you can put this into your .Rprofile (after lines that
set your CRAN mirror):

``` r
local({r <- getOption("repos")
# add drat repo
r["scholaempirica"] <- "https://scholaempirica.github.io/drat"
options(repos=r)})
```

(use `usethis::edit_r_profile()` to open .Rprofile for editing.)

Then, you can simply run `install.packages("reschola")` and the latest
binary release of `reschola` will be installed even though it is not on
CRAN.

## What is inside the box and how to use it

See the [Getting started](articles/reschola.html) vignette
(`vignette('reschola', package = 'reschola')`) for an overview of
templates, utilities and guidance in this package that together provide
the infrastructure and mental models for the Schola Empirica way of
working with data and reporting.

## Acknowledgments

All content in this package arose out of conversations with the guys at
Schola Empirica and their desire to do data analysis well.

The tools and concepts contained in it are heavily inspired by many
wonderful members of the R community; references to specific
contributions are contained in individual vignettes.

Logo made using <https://connect.thinkr.fr/hexmake/>. The approach to
project templates and some other components is heavily inspired by
[ratlas](https://github.com/atlas-aai/ratlas/), including the reuse of
components from [hrbrthemes](https://hrbrmstr.github.io/hrbrthemes/).
