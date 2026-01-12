# Getting started

This document describes the basics of working with this package and
provides signposting to more detailed documentation of setup and
workflow used at Schola Empirica.

The most important components include:

### Guidance on how to set up your computer and your mind for doing data analysis the Schola way

See the
[Setup](https://scholaempirica.github.io/reschola/articles/setup.md)
vignette
([`vignette('setup', package = 'reschola')`](https://scholaempirica.github.io/reschola/articles/setup.md)).

(If R cannot find the vignette, make sure you add
`build_vignettes = TRUE` in `install_github("scholaempirica/reschola)`).

There are tips for setup in the
[tips](https://scholaempirica.github.io/reschola/articles/tips.md)
vignette.

### An Rstudio project template for easy project setup

This is accessed through the RStudio menu: File \> New project \> New
directory \> Standard Schola Empirica Project.

See the
[Workflow](https://scholaempirica.github.io/reschola/articles/workflow.md)
vignette for how to make the best use of the template in the context of
the Schola Empirica workflow.
([`vignette('workflow', package = 'reschola')`](https://scholaempirica.github.io/reschola/articles/workflow.md)).

### Templates for producing reports in the Schola style

Accessed through the RStudio menu:
`File > New File > R Markdown > From Template` \> \[scroll down to
reschola package\], or through `draft_*` functions in the reschola
package.

See the
[Workflow](https://scholaempirica.github.io/reschola/articles/workflow.md)
vignette
([`vignette('workflow', package = 'reschola')`](https://scholaempirica.github.io/reschola/articles/workflow.md))
for details.

There are tips for working efficiently and for packages for specific
tasks in the
[tips](https://scholaempirica.github.io/reschola/articles/tips.md)
vignette.

### A ggplot2 theme in the Schola style and related plotting utilities

See [Making charts
\[TODO\]](https://scholaempirica.github.io/reschola/articles/charts.md)
vignette
([`vignette('charts', package = 'reschola')`](https://scholaempirica.github.io/reschola/articles/charts.md))
for details and related guidance and resources on making charts in
`ggplot2`.

### Meta: keeping this packate up to date and up to scratch

This package should be a living, evolving tool and a set of living
documents. See the See [Developing this pacakge
further](https://scholaempirica.github.io/reschola/articles/meta.md)
vignette
([`vignette('meta', package = 'reschola')`](https://scholaempirica.github.io/reschola/articles/meta.md))
to understand how this package is being developed and thus how it can be
extended and updated.

You can get a list of these vignettes in R by entering
`browseVignettes('reschola')` and view them locally if you wish
