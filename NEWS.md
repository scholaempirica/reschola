# reschola (development version)

## Documentation additions

* explainer on renv added to workflow vignettes
* new tips on EDA and CRAN views

## Changes

* template-based project setup no longer runs redoc so things work on Windows with broken encoding settings 

## Bug fixes

* updated repo URLs in install instructions in README.[R]md

# reschola 0.2.10

## New features

* New Making charts vignette
* minor additions to tips and workflow vignettes
* new scales: `scale_[x|y]_percent_cz()`, `scale_[x|y]_number_cz()`
* analogous English-locale scales reexported from `hrbrthemes`: `scale_[x|y]_comma()` and `scale_[x|y]_percent()`
* new label formatters: `label_number_cz()` and `label_percent_cz()` (the English-language analogs without `_cz` are in the package `scales`)

## Changes

* minor changes to Word template files around image captions
* added `margin_bottom` param to `theme_schola()`
* renamed `left_margin` to `margin_left` in `theme_schola()`

# reschola 0.2.9

## Improvements

* updated styles in Word templates for both Rmd templates
* switched logo in Word templates to right side
* added preparation for using cross-refs in docx: localisation, documentation, examples
* updated RMarkdown outputs to get figures nice and right size

## Bug fixes

* project setup now creates `data-raw` and `data-processed` such that the directories can go into git but not its contents; documentation explains this in multiple places.
* `draft_redoc()` no longer leaves behind a stray docx file

# reschola 0.2.8

## Bug fixes

* `draft_redoc()` now works outside of a reschola-created project
* project template should no longer fail on Google Drive authentication; guidance added to vignettes to prevent/handle this
* workflow vignette and getting started guide in new project now correctly refer to `data-processed` directory 
* data reading script created by project template now correctly named `001_read-data.R`.

## Improvements

* new naming scheme of scripts pre-created by project template for better sorting
* `data-input` and `data-processed` directories in new project are now automatically added to `.gitignore`
* additions and clarifications in vignettes
* added search capability to website
* clarified workflow text on project creation
* added note on encoding in Workflow article
* added guidance in setupa and workflow vignettes on RStudio Cloud, R configuration, citations, and setting CRAN mirrors
* more guidance in RMarkdown templates

# reschola 0.2.7

## Bug fixes

* fixed bug in project template where a newly created RMd file did not open
* refactored `draft_redoc()` to fix roundtripping issue and improve UI

## Improvements

* added preliminary setup documentation on locales
* added documentation on using schola_redoc template
* new bits of workflow documentation on good practice and code style

# reschola 0.2.6

* project template now creates a reproducibility script
* getting-started doc in project template is more fleshed out
* first draft of new Workflow vignette
* first draft of new Setup vignette
* more detail in Tips & Tricks vignette

# reschola 0.2.5

## Bug fixes

* updated `drat` repo link in README so `install.packages()` no longer fails
* fixed bug where project template failed when copying standard logos

## Improvements

* added basic files to default project structure
* better file names in default structure
* clearer wording and layout of project template dialog
* Bootstrap-style callouts can now be used in vignettes (will only show on website)
* added tips on accessing documentation in tips vignette, and on snippets

## New features

* new `gd_download_folder()` function for downloading all files in a GDrive folder
* option in project template to download files from the listed GDrive folder
* project template now helps user authenticate to GDrive if they set a GDrive URL

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
