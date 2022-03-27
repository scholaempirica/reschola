# reschola (development version)

## Changes

- package logo slightly updated
- `recover_labs()` has relaxed assumptions about old and new dataframes column names and number of columns. From now on, only a warning is issued.
- `fct_nanify()` will not abort when the factor to NAnify is not present in the data and will return the original input with a warning
- user `.Rprofile` is now sourced in project's `.Rprofile`, so you may still use functions or values defined in the user-scoped version

## New features

- `extract_schola_barplot_info()` for easy access to a data underlying `schola_barplot()` output

## Bugfixes

- `fct_nanify()` no longer fails when there are `NA`s in the match vector

<!-- TODO -----------------------------------------------------
- PDF template: incorporate changes from IvP and EZ, especially citations and so on
-->

# reschola 0.5.1

This is a minor patch solving the following two issues:

## Bugfixes

- `fct_nanify()` no longer warns about level order each time it is called
- `recover_labs()` does not check the number of rows of dataframes (too restrictive & not intended originally)


# reschola 0.5.0 (Welcome, Ubuntu)

This release is focused on the new SCHOLA EMPIRICA visual style and replaces Roboto with Ubuntu font. It also adds wrappers for creating the Schola-styled lollipop and barplot plots to be used in our reports. These come with a bunch of utils, such as custom labeller which is useful for labeling plots' facets, tightly tied with `dict_from_data()` that you'll use for extracting labeling specifications from the labels that come from LimeSurvey via our API. In case of labels being stripped from the dataframe, the new `recover_labs()` function may be handy. As usual many bugs were fixed and a few utils functions were added. Take a look:

## Changes

- `{reschola}` now adheres to SCHOLA EMPIRICA visual style by adopting Ubuntu and Ubuntu Condensed fonts
- `gd_download_folder()` now overwrites existing content by default
- all files created at project start-up are now committed in the initial "Repo set-up" commit
- Google Drive URL saved in `.Rprofile` at project set-up is now automatically trimmed and all queries that might boggle `{googledrive}` are removed
- `fct_nanify()` now matches using a regular expression, friendly *message* displaying only once per session
- Google Drive URL inside `share.R` is removed for future projects, as it is now governed by a feature introduced in `{reschola}` 0.4.0

## New features

- `schola_barplot()` for Likert-type items, displaying grouped data per variable for straightforward comparison
- `prepare_lollipop_data()` and `plot_lollipop()` for creating lollipop plots
- `dict_from_data()` extracts named character vector of item code-label pairs
- `schola_labeller()` is a labeller for `{ggplot2}` facets that utilizes item labels, with wrapping
- `with_clr()` creates text with color as a span HTML tag, especially useful shortcut when you use `ggtext::geom_richtext()` or `ggtext::element_markdown()` richtext
- `build_all.R` script now comes with a few lines that'll process all scripts inside `data` directory
- new utils functions:
  - `recover_labs()` for recovering lost variable labels (such as those coming from `ls_*()` export functions); with infix operator available: `%labs_from%`
  - `get_labs_df()` for quick labels check (the most user-friendly is to use `View()` in RStudio, though)
  - `remove_empty_at()` to drop observations that are completely empty *at specified variables*; note `tidyr::drop_na()` have a similar usage, but it drops rows containing *any* missing values, not those with *all* missings

## Bugfixes

- cropping of PDF figures was silently in charge for users with working `pdfcrop` and `ghostscript`. It is now off by default.
- project set-up error claiming directories does not exist fixed
- `theme_schola()` now uses 1.5pt top margin, so diacritics of certain letters doesn't get cut.
- `clean_labels = FALSE` in `ls_responses()` (and fellows) does not fail anymore
- `czech_date_interval()` now returns correct class (should have always been `czech_date_interval` not `character`; furthemore, if start and end dates were identical, it even returned `POSIXct`/`POSIXt`, which produced hard-to-debug issues when used inside `{dplyr}`'s `summarise`)
- fixed missing attributes were not recognized in `ls_*()` functions (those are coded `NA` in recent LimeSurvey); more verbose info

## Documentation

- `gd_get_proj()` now provides instruction for those who want to use the feature but created their `{reschola}` project before version 0.4.0


# reschola 0.4.0 (New Beginnings)

In this release, we have changed a standard project structure to be more organised keeping in mind not to clutter the project's root directory with too many files. Next, font installation and usage backend was completely revamped and should now work straight out of the box on any machine – without any dependencies needed. Last, but not least, our default `{ggplot2}` theme has been report-first tailored and cropping utilities are not needed any more. And as usual, many bugs were fixed.

## Breaking changes

- default project structure changes and clean-up
- schola project options clean-up
- new font installation and registration routines for Windows, see `install_reschola_fonts()` and `register_reschola_fonts()`
- updated `theme_schola()`
  - no margins by default (argument `margin` supersedes `margin_side` and `margin_bottom`)
  - axis titles on by default (+ `axis.title` renamed to `axis_title`)
- figure cropping with `ghostscript` and `pdfcrop` is defunct, so those are no longer needed (see above)
- new Google Drive handling -- URL is set in `.Rprofile` as a hidden object that can be accessed by `gd_get_proj()`

## Changes

- current logos added
- new `draft_pdf()`
- start-up message
- project set-up exceptions better handled
- `set_reschola_ggplot_fonts()` without dependencies and more customisable (although changes are not recommended); new geoms covered
- new `fct_nanify()` for recoding a factor level to `NA`
- new functions for quick RDS data manipulation:
  - `get_input_data()`
  - `get_intermediate_data()`
  - `get_processed_data()`
  - `write_input_data()`
  - `write_intermediate_data()`
  - `write_processed_data()`
- new function `gd_upload_file()` for quick file uploads
- `gd_download_folder()` now uses project's Google Drive URL stored in `.Rprofile` as `folder_url` argument by default

## Bugfixes

- `ls_participants()` runs properly when there are no attributes to translate and `translate_attrs = TRUE`

## Documentation

- `{pkgdown}` online documentation leverages `Bootstrap 5`
- info about `babel` TeX package hyphenation warning mitigation in `schola_pdf()` (using `tinytex::tlmgr_install("hyphen-czech")`)
- `?theme_schola` enumerates `...` arguments that `theme()` understands


# reschola 0.3.3 (Save the Fonts)

## Breaking changes

- `redoc` reversible Word format is now completely removed from the package; from now on, use `schola_pdf()` primarily (`schola_word()` is still available)

## Changes

- PDF template now handles footnotes better
- `czech_date_interval()` now raises an error when you try to supply more than one entry
- `ls_call()` gives an error when you try to provide another `sSessionKey` in `params`
- `ls_call()` passes `error` message to the user when there is one
- `ls_call()` replaces `NULL`s with `NA`s (thus more API responses can be turned into a tibble)
- `ls_call()` messaging is less disruptive
- the documentation is more verbose on some topics
- fonts registration is now more verbose and `import_fonts()` checks that everything went well; solutions are provided otherwise

## New features

- `ls_responses()` (and thus `ls_export()`) strips out the `tibble`-wide `variable.labels` attribute and spreads it among the individual variables, which enables you to modify the `tibble` without messing the labels positions and/or producing length incompatibilities
- `ls_export()` gains new argument `clean_labels` which by default cleans up repeating parts of labels of sub-questions (i.e., those outside square brackets)
- new function `ls_set_participant_properties()` enabling you to set or edit participant table
- new function `copy_schola_template()` which copies the template (`pdf` by default) into the active project directory

## Bug fixes

- `czech_date_interval()` now correctly suppresses redundant information
- you are now informed about a solution when font registration fails, this concerns a bug in recent version of `Rttf2pt1` utility that the process rely on

# reschola 0.3.2 (Limy Schola)

## Changes

- default LimeSurvey API endpoint protocol changed to HTTPS

# reschola 0.3.1 (Limy Schola)

A tiny patch release resolving the issues with and simplifying the font installation process.

## Documentation
- fonts installation described in more detail, warning NOTE added

## Changes
- font installation is now carried out by a single function `import_fonts()`
- all fonts needed for the package functionality now comes in `reschola` and are not resourced from `hrbrthemes` any more
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
    - takes care of non-breakable spaces in Czech (especially before single-character prepositions) via pre-release `pandoc` Lua filter (only repo fork currently, thanks [Delanii](https://github.com/Delanii/lua-filters))
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
-   examples and description of template handling in `schola_word()`
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
-   two new functions: `schola_word2()` gives the user control over the reference Word document (a.k.a. template), `open_schola_word_template` automatically locates and opens up the aforementioned template that comes with the package to simplify and speed up the work with the template

## Bug fixes

-   default `theme_schola` now uses the same colour everywhere (caption colour was in solid black)
-   extra parenthesis in README removed

# reschola 0.2.11

## Documentation additions

-   explainer on renv added to workflow vignettes
-   new tips on EDA and CRAN views

## Changes

-   template-based project set-up no longer runs redoc so things work on Windows with broken encoding settings

## Bug fixes

-   updated repo URLs in install instructions in README.[R]md

# reschola 0.2.10

## New features

-   New Making charts vignette
-   minor additions to tips and workflow vignettes
-   new scales: `scale_[x|y]_percent_cz()`, `scale_[x|y]_number_cz()`
-   analogous English-locale scales re-exported from `hrbrthemes`: `scale_[x|y]_comma()` and `scale_[x|y]_percent()`
-   new label formatters: `label_number_cz()` and `label_percent_cz()` (the English-language analogues without `_cz` are in the package `scales`)

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

-   project set-up now creates `data-raw` and `data-processed` such that the directories can go into git but not its contents; documentation explains this in multiple places.
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
-   added guidance in set-ups and workflow vignettes on RStudio Cloud, R configuration, citations, and setting CRAN mirrors
-   more guidance in RMarkdown templates

# reschola 0.2.7

## Bug fixes

-   fixed bug in project template where a newly created RMd file did not open
-   refactored `draft_redoc()` to fix round-tripping issue and improve UI

## Improvements

-   added preliminary set-up documentation on locales
-   added documentation on using schola_redoc template
-   new bits of workflow documentation on good practice and code style

# reschola 0.2.6

-   project template now creates a reproducibility script
-   getting-started doc in project template is more fleshed out
-   first draft of new Workflow vignette
-   first draft of new Set-up vignette
-   more detail in Tips & Tricks vignette

# reschola 0.2.5

## Bug fixes

-   updated `drat` repo link in README so `install.packages()` no longer fails
-   fixed bug where project template failed when copying standard logos

## Improvements

-   added basic files to default project structure
-   better file names in default structure
-   clearer wording and layout of project template dialogue
-   Bootstrap-style callouts can now be used in vignettes (will only show on website)
-   added tips on accessing documentation in tips vignette, and on snippets

## New features

-   new `gd_download_folder()` function for downloading all files in a GDrive folder
-   option in project template to download files from the listed GDrive folder
-   project template now helps user authenticate to GDrive if they set a GDrive URL

# reschola 0.2.4

-   removed `font_rc_light` as Roboto Condensed Light does not work in Windows with ggplot2
-   improved guidance in `import_fonts()`
-   added guidance in meta vignette on changing things in the package, plus acknowledgements
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
-   font set-up steps documented in vignettes and `theme_schola()` doc

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
