# reschola 0.2.4

* removed `font_rc_light` as Roboto Condensed Light does not work in Windows with ggplot2
* improved guidance in `import_fonts()`
* added guidance in meta vignette on changing things in the package, plus acknowledgments
* improved UI for draft_word()
* improved UI for draft_redoc(); it now also roundtrips the new file for cleaner reversion from docx edits
* updated docx templates: page size, margins
* new `manage_docx_header_logos()` function for adding/replacing logos in Word docs created using reschola templates

# reschola 0.2.3

* fixed issue which prevented package from loading in some cases

# reschola 0.2.2

* added the right logos into RStudio template*
* improved RMarkdown template content
* font defaults in `theme_schola()` + functions for font import and setting `geom_*` defaults
* font setup steps documented in vignettes and `theme_schola()` doc

# reschola 0.2.1

* RStudio project template now creates default folder structure
* New project creation option to show a Getting started guide
* New project using template now contains README.md, shared.R and build.R with instructions

# reschola 0.2.0

* improved README and added "Getting started" vignette
* basic `theme_schola()` added for early feedback, together with vignette
* key R and RStudio tips in `tips.html` vignette
* complete `meta.html` vignette on developing this package
* handle pre-computing of `charts.html` vignette to get around missing fonts on Travis
* working project template
* rely on patched `redoc` which fixes addin error and an error in documentation
* new pkdown site 

# reschola 0.1.0

* foundations of Rmarkdown templates and output format
* foundations of an RStudio project template for project initiation

# reschola 0.0.0.9000

* package basics
* Added a `NEWS.md` file to track changes to the package.
