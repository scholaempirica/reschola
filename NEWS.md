# reschola (development version)

## Changes

- PDF template now handles footnotes better
    - TODO - incorporate changes from IvP and EZ, especially citations and so
- `czech_date_interval()` now raises an error when you try to supply more than one entry
- `ls_responses()` strips out the `tibble`-wide `variable.labels` attribute and spreads it among the individual variables, which enables you to modify the `tibble` without messing the labels positions and/or producing length incompatibilities
- `ls_call()` gives an error when you try to provide another `sSessionKey` in `params`
- `ls_call()` passes `error` message to the user when there is one
- `ls_call()` replaces `NULL`s with `NA`s (thus more API responses can be turned into a tibble)
- the documentation is more verbose on some topics

## New features

- new function `copy_schola_template()` which copies the template (`pdf` by default) into the active project directory
- new function `ls_set_participant_properties()` enabling you to set or edit participant table

## Bug fixes

- `czech_date_interval()` now correctly suppresses redundant information 

# reschola 0.3.2 (Limy Schola)

## Changes

- default LimeSurvey API endpoint protocol changed to HTTPS

# reschola 0.3.1 (Limy Schola)

A tiny patch release resolving the issues with and simplifying the font installation process.

## Documentation
- fonts installation described in more detail, warning NOTE added

## Changes
- font installation is now carried out by a single function `import_fonts()`
- all fonts needed for the package functionality now comes in `reschola` and are not resourced from `hrbrthemes` anymore
- `import_fonts()` is now more verbose on the instruction
- `reschola` font directory is now opened automatically
- some namespace-prepended function calls replaced with proper `importFrom` declarations 

# reschola 0.3.0 (Limy Schola)

## Breaking changes

- automatically generated build script `build.R` is renamed to `build_all.R`, to allow multiple build scripts (pro tip: use [{buildr}](https://CRAN.r-project.org/web/packages/buildr/) package)

## New features

- new R Markdown document format `schola_pdf()`:
    - powered by custom LaTeX template and `report` class
    - uses Roboto font
    - reasonable defaults are used so the YAML header is not cluttered with stuff
    - figures are in PDF (via `cairo` device so non-ASCII characters are well supported) and are cropped automatically (new function `ensure_cropping()` that checks for dependencies needed for proper format functioning, providing help when an issue is discovered)
    - takes care of non-breakable spaces in Czech (especially before singlecharacter prepositions) via pre-release `pandoc` Lua filter (only repo fork currently, thanks [Delanii](https://github.com/Delanii/lua-filters))
    - handy `author` Pandoc variable (used in YAML header), which takes the language `lang` and automatically typesets the "and" or "a" separator before the last author (when there is only one, no separators are introduced whatsoever)


- `reschola` is now armed with its own LimeSurvey API interface, providing several functions tailored to our needs:
    - `ls_call()` implements general and fully customisable call to the API (you must adhere to [the documentation](https://api.limesurvey.org/classes/remotecontrol_handle.html))
    - `ls_export()` is going to be used most of the time, as it fetches both participants and their responses, it basically merges outputs from  `ls_participants()`, and `ls_responses()`
    - `ls_login()` is used for manual session key request; **it may be never used directly**, as every `ls_` call ensures the key is cached and not expired (key is stale after 2 hrs)
    - `ls_add_participants()` inserts one or more participants to the LimeSurvey database
    - `ls_invite()` sends an email invitation prepared in LimeSurvey web interface to the selected participants
    - `ls_get_attrs()` for retrieval of the custom survey attributes and their "semantic" form (i.e. human-readable description)
    
    
- new class `czech_date` with S3 method that prints the date in long format and with grammatically correct case, more in `as_czech_date()`
- new function `czech_date_interval()` that takes two dates and returns nicely formatted Czech date interval
    - czech date interval tries to print using non-breakable *en dash* when `pandoc` outputs to `LaTeX` (i.e., `schola_pdf()` format is used)
- new function `compile_and_open()` provides safe and comfortable way to render/compile `.Rmd` documents
- vector graphics logo of SCHOLA EMPIRICA in `.pdf` added
- development feature: *spellcheck on package introduced via `usethis`*

## Changes

- `99_reproducibility.Rmd` now uses base R `sessionInfo()`, not `sessioninfo` package, which seems like an unnecessary dependency

## Bug fixes

- organization name change to correct form
- `ggplot2::ScaleContinuousPosition` correctly imported, but still WIP
- `ls_participants()` handles attributes correctly when used as a character vector


# reschola 0.2.13

## Documentation additions

-   "intelligent" quotation marks introduced ([\#76](https://github.com/scholaempirica/reschola/issues/76))
-   examples and desription of template handling in `schola_word()`
-   `schola_word2()` deprecated

## Changes

-   main Word output format is `schola_word()`, which now uses default template if no reference document is provided in YAML
-   `pandoc lua` filter for quotation marks integrated into Word template
-   proper Czech number format supported in inline markdown content (i.e. `` `r rnorm(1)` ``)
-   `theme_schola` is set to default in `rmarkdown` skeleton
-   package name changed to comply with CRAN check
-   default caption prefix "Obrázek" changed to "Graf", "Tabulka" to "Tab."
-   typos in `build.R` fixed ([\#79](https://github.com/scholaempirica/reschola/issues/79))
-   better-looking date without leading zeros
-   ToC now present in YAML by default
-   `lifecycle` package introduced
-   switched from Travis continuous integration to GitHub Actions
-   GitHub issue templates

## Bug fixes

-   `theme_schola()` works again with `manage_docx_header_logos()` and comes with SCHOLA EMPIRICA logo preloaded

# reschola 0.2.12

## Documentation additions

-   "templating" explained in `schola_word2()`, with a link to `bookdown` manual

## Changes

-   the main Word template now uses Roboto font everywhere, pages are auto-numbered, ToC is properly formatted, text is justified
-   two new functions: `schola_word2()` gives the user control over the reference Word document (a.k.a. template), `open_schola_word_template` automatically locates and opens up the aforementioned template that comes with the package to simplify and speed up the workd with the template

## Bug fixes

-   default `theme_schola` now uses the same colour everywhere (caption colour was in solid black)
-   extra parenthesis in README removed

# reschola 0.2.11

## Documentation additions

-   explainer on renv added to workflow vignettes
-   new tips on EDA and CRAN views

## Changes

-   template-based project setup no longer runs redoc so things work on Windows with broken encoding settings

## Bug fixes

-   updated repo URLs in install instructions in README.[R]md

# reschola 0.2.10

## New features

-   New Making charts vignette
-   minor additions to tips and workflow vignettes
-   new scales: `scale_[x|y]_percent_cz()`, `scale_[x|y]_number_cz()`
-   analogous English-locale scales reexported from `hrbrthemes`: `scale_[x|y]_comma()` and `scale_[x|y]_percent()`
-   new label formatters: `label_number_cz()` and `label_percent_cz()` (the English-language analogs without `_cz` are in the package `scales`)

## Changes

-   minor changes to Word template files around image captions
-   added `margin_bottom` param to `theme_schola()`
-   renamed `left_margin` to `margin_left` in `theme_schola()`

# reschola 0.2.9

## Improvements

-   updated styles in Word templates for both Rmd templates
-   switched logo in Word templates to right side
-   added preparation for using cross-refs in docx: localisation, documentation, examples
-   updated RMarkdown outputs to get figures nice and right size

## Bug fixes

-   project setup now creates `data-raw` and `data-processed` such that the directories can go into git but not its contents; documentation explains this in multiple places.
-   `draft_redoc()` no longer leaves behind a stray docx file

# reschola 0.2.8

## Bug fixes

-   `draft_redoc()` now works outside of a reschola-created project
-   project template should no longer fail on Google Drive authentication; guidance added to vignettes to prevent/handle this
-   workflow vignette and getting started guide in new project now correctly refer to `data-processed` directory
-   data reading script created by project template now correctly named `001_read-data.R`.

## Improvements

-   new naming scheme of scripts pre-created by project template for better sorting
-   `data-input` and `data-processed` directories in new project are now automatically added to `.gitignore`
-   additions and clarifications in vignettes
-   added search capability to website
-   clarified workflow text on project creation
-   added note on encoding in Workflow article
-   added guidance in setups and workflow vignettes on RStudio Cloud, R configuration, citations, and setting CRAN mirrors
-   more guidance in RMarkdown templates

# reschola 0.2.7

## Bug fixes

-   fixed bug in project template where a newly created RMd file did not open
-   refactored `draft_redoc()` to fix roundtripping issue and improve UI

## Improvements

-   added preliminary setup documentation on locales
-   added documentation on using schola_redoc template
-   new bits of workflow documentation on good practice and code style

# reschola 0.2.6

-   project template now creates a reproducibility script
-   getting-started doc in project template is more fleshed out
-   first draft of new Workflow vignette
-   first draft of new Setup vignette
-   more detail in Tips & Tricks vignette

# reschola 0.2.5

## Bug fixes

-   updated `drat` repo link in README so `install.packages()` no longer fails
-   fixed bug where project template failed when copying standard logos

## Improvements

-   added basic files to default project structure
-   better file names in default structure
-   clearer wording and layout of project template dialog
-   Bootstrap-style callouts can now be used in vignettes (will only show on website)
-   added tips on accessing documentation in tips vignette, and on snippets

## New features

-   new `gd_download_folder()` function for downloading all files in a GDrive folder
-   option in project template to download files from the listed GDrive folder
-   project template now helps user authenticate to GDrive if they set a GDrive URL

# reschola 0.2.4

-   removed `font_rc_light` as Roboto Condensed Light does not work in Windows with ggplot2
-   improved guidance in `import_fonts()`
-   added guidance in meta vignette on changing things in the package, plus acknowledgments
-   improved UI for draft_word()
-   improved UI for draft_redoc(); it now also roundtrips the new file for cleaner reversion from docx edits
-   updated docx templates: page size, margins
-   new `manage_docx_header_logos()` function for adding/replacing logos in Word docs created using reschola templates

# reschola 0.2.3

-   fixed issue which prevented package from loading in some cases

# reschola 0.2.2

-   added the right logos into RStudio template\*
-   improved RMarkdown template content
-   font defaults in `theme_schola()` + functions for font import and setting `geom_*` defaults
-   font setup steps documented in vignettes and `theme_schola()` doc

# reschola 0.2.1

-   RStudio project template now creates default folder structure
-   New project creation option to show a Getting started guide
-   New project using template now contains README.md, shared.R and build.R with instructions

# reschola 0.2.0

-   improved README and added "Getting started" vignette
-   basic `theme_schola()` added for early feedback, together with vignette
-   key R and RStudio tips in `tips.html` vignette
-   complete `meta.html` vignette on developing this package
-   handle pre-computing of `charts.html` vignette to get around missing fonts on Travis
-   working project template
-   rely on patched `redoc` which fixes addin error and an error in documentation
-   new pkgdown site

# reschola 0.1.0

-   foundations of Rmarkdown templates and output format
-   foundations of an RStudio project template for project initiation

# reschola 0.0.0.9000

-   package basics
-   Added a `NEWS.md` file to track changes to the package.
