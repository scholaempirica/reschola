# reschola

The goal of reschola is to support the workflow for data analysis at
[Schola Empirica](http://scholaempirica.org) through a set of templates,
themes, utilities, and documentation. The vignettes for the package
document the Schola Empirica way of doing data analysis and provide
guidance and tips on tools and good practice.

## Installation

You can install the *released* version of reschola from
[Github](https://github.com) with:

``` r
remotes::install_github(
  "scholaempirica/reschola",
  ref = remotes::github_release(),
  build_vignettes = TRUE
)
```

`r-universe` is kindly building and hosting compiled binaries of the
current *development versions* for Windows and MacOS, so you can proceed
with a standard call with `r-universe` repository specified:

``` r
install.packages("reschola", repos = "https://scholaempirica.r-universe.dev")
```

This could be done with `remotes` as well, by ommiting the `ref`
argument:

``` r
remotes::install_github("scholaempirica/reschola", build_vignettes = TRUE)
```

## What is inside the box and how to use it

See the [Getting
started](https://scholaempirica.github.io/reschola/articles/reschola.md)
vignette
([`vignette('reschola', package = 'reschola')`](https://scholaempirica.github.io/reschola/articles/reschola.md))
for an overview of templates, utilities and guidance in this package
that together provide the infrastructure and mental models for the
Schola Empirica way of working with data and reporting.

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
