
<!-- README.md is generated from README.Rmd. Please edit that file -->

# reschola <a href='https://scholaempirica.github.io/reschola'><img src='man/figures/logo.png' align="right" height="139" /></a>

<!-- badges: start -->

[![Travis build
status](https://travis-ci.org/scholaempirica/reschola.svg?branch=master)](https://travis-ci.org/scholaempirica/reschola)
<!-- badges: end -->

The goal of reschola is to provide a set of utilities for data analysis
at [Schola Empirica](https://scholaempirica.org). The vignettes for the
package also document the Schola Empirica way of doing data analysis.

## Installation

You can install the released version of reschola from
[Github](https://github.com) with:

``` r
remotes::install_github("scholaempirica/reschola", ref = remotes::github_release())
```

The current development version [Github](https://github.com) can be
installed with:

``` r
remotes::install_github("scholaempirica/reschola")
```

If you are having trouble installing packages from sources, the binaries
of `reschola` are available in [the Schola `drat`
repository](http://scholaempirica.github.io/drat). This is a package
repository that can be used in the same way as CRAN, meaning you can use
`install.packages()` and if binaries are available, you don’t need
development tools to compile source packages.

You can install binaries from Schola `drat` like so:

``` r
install.packages("reschola", repos = "https://scholaempirica.github.io/drat/")
```

If you want to always have direct access to this `drat` repository like
you have to CRAN, you can put this into your .Rprofile:

``` r
local({r <- getOption("repos")
# add drat repo
r["scholaempirica"] <- "scholaempirica.github.io/drat"
options(repos=r)})
```

Then, you can simply run `install.packages("reschola")` and the latest
binary release of `reschola` will be installed even though it is not on
CRAN.

## What is inside the box and how to use it

See the [Getting started](reschola.html) vignette (`vignette('reschola',
package = 'reschola')`) for an overview of templates, utilities and
guidance in this package that together provide the infrastructure and
mental models for the Schola Empirica way of working with data and
reporting.

## Acknowledgments

All content in this package arose out of conversations with the guys at
Schola Empirica and their desire to do data analysis well.

The tools and concepts contained in it are heavily inspired by many
wonderful members of the R community; references to specific
contributions are contained in individual vignettes.

Logo made using <https://connect.thinkr.fr/hexmake/>. The approach to
project templates and some other components is heavily inspired by
[ratlas](https://github.com/atlas-aai/ratlas/), including the reuse of
components from [hrbrthemes]().