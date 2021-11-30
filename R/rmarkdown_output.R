
#' Schola Empirica PDF Format
#'
#' Function called in the output section of the YAML header (see examples
#' below), instructing `knitr` to use the standard Schola PDF document format.
#' If you run into any problem using the Czech language, consult this function
#' details first.
#'
#' @section Package `babel` hyphenation warning:
#' You may encounter a following warning when your document is being "compiled"
#' to `.pdf` format:
#' ```
#' Warning: Package babel Warning: No hyphenation patterns were preloaded for
#' Warning: (babel)                the language 'Czech' into the format.
#' Warning: (babel)                Please, configure your TeX system to add them and
#' Warning: (babel)                rebuild the format. Now I will use the patterns
#' Warning: (babel)                preloaded for \language=0 instead on input line 53.
#' ```
#' This usually solves by calling `tinytex::tlmgr_install("hyphen-czech")` (if
#' you are a `{tinytex}` user).
#'
#' @param toc *Logical*, `TRUE` (default) to include a table of contents. The
#'   title is set with `pandoc` variable `toc-title` in YAML header.
#' @param fig_crop *Logical*, whether to crop transparent or white margins of
#'   figures. Defaults to `TRUE`. Note that for cropping to work, two
#'   dependencies needs to be satisfied, see `?ensure_cropping`.
#' @param template *Character*, path to the `.tex` template used by the format.
#'   Defaults to standard Schola template bundled in the package. **Changes
#'   discouraged.**
#' @param num_format *Character*, if `cs`, Czech number formatting is used.
#'   Other values are currently ignored and will result in default options.
#' @param latex_engine *Character*, engine used for `.md` to `.pdf` conversion.
#'   Only `xelatex` (the default) and `lualatex` are supported because of custom
#'   fonts. **Changes discouraged.**
#' @param document_class *Character*, one of standard LaTeX document class.
#'   Defaults to `report`. **Changes discouraged.**
#' @param number_sections *Logical*, `TRUE` to number headings. Defaults to
#'   `FALSE`.
#' @inheritDotParams rmarkdown::pdf_document -toc -latex_engine -template
#'   -fig_width -fig_height -dev -number_sections -fig_crop
#'
#' @return A modified `pdf_document2` with the standard Schola formatting.
#'
#' @author Jan Netik
#'
#' @examples
#' \dontrun{
#' # in YAML header ------
#' output:
#'   reschola::schola_pdf:
#'     toc: false
#' }
#'
#' @family Report templates and formats
#'
#' @importFrom bookdown pdf_document2
#' @importFrom usethis ui_stop ui_code
#' @importFrom tools find_gs_cmd
#' @export
#'
schola_pdf <- function(num_format = NULL, fig_crop = TRUE,
                       number_sections = FALSE, toc = TRUE,
                       template = find_resource("schola_pdf", "schola_template.tex"),
                       latex_engine = "xelatex", document_class = "report", ...) {
  base <- pdf_document2(
    toc = toc, fig_crop = fig_crop, template = template,
    number_sections = number_sections, latex_engine = latex_engine, ...
  )

  base$pandoc$args <- c(
    base$pandoc$args, "--variable", paste0("documentclass=", document_class)
  )

  # enforce plot cropping (see https://github.com/rstudio/rmarkdown/issues/2016)
  # rmarkdown 2.7+ now throws a warning, but I think error is more suitable
  if (fig_crop) {
    tools_absent <- c(!nzchar(Sys.which("pdfcrop")), !nzchar(find_gs_cmd()))
    if (any(tools_absent)) {
      ui_stop("Figure cropping dependencies are not satisfied.\nRun {ui_code('ensure_cropping()')} or set {ui_value('fig_crop')} argument to FALSE.")
    }

    base$knitr$knit_hooks$crop <- knitr::hook_pdfcrop
    base$knitr$opts_chunk$crop <- TRUE
  }

  # replaces plain quotation marks with typographic ones
  quotes_lua_filter <- system.file("pandoc", "pandoc-quotes.lua", package = "reschola")

  # nonbreakable spaces in Czech/English,
  # a.k.a pandoc Lua reboot of famous "vlna" by Petr Olsak
  # from https://github.com/Delanii/lua-filters
  vlna_lua_filter <- system.file("pandoc", "pandocVlna.lua", package = "reschola")

  base$pandoc$lua_filters <- c(
    quotes_lua_filter,
    vlna_lua_filter,
    base$pandoc$lua_filters
  )

  # czech numbers
  if (!is.null(num_format) && num_format == "cs") {
    base$knitr$knit_hooks$inline <- function(x) {
      if (!is.character(x)) {
        prettyNum(x, big.mark = " ", decimal.mark = ",")
      } else {
        x
      }
    }
  }

  # nolint start
  base$knitr$opts_chunk$comment <- "#>" # as in reprex package, standard MD
  base$knitr$opts_chunk$message <- FALSE
  base$knitr$opts_chunk$warning <- FALSE
  base$knitr$opts_chunk$error <- FALSE
  base$knitr$opts_chunk$echo <- FALSE
  base$knitr$opts_chunk$cache <- FALSE
  base$knitr$opts_chunk$fig.width <- 6.29
  base$knitr$opts_chunk$out.width <- "\\textwidth"
  base$knitr$opts_chunk$dev <- "cairo_pdf" # for support of non-ASCII chars, namely
  base$knitr$opts_chunk$fig.asp <- .618 # golden ratio
  base$knitr$opts_chunk$fig.path <- "figures/" # if Ghostscript and pdfcrop are avaiable, they are cropped
  base$knitr$opts_chunk$fig.align <- "center"
  # nolint end

  base
}

#' Ensure That Figure Cropping Dependencies Are Satisfied
#'
#' Checks if the dependencies needed for the `schola_pdf` format to work
#' properly and as intended are satisfied. If not, solution is offered.
#'
#' In order to use automated cropping of PDF figures, the `PDFCrop` utility
#' (shipped with TinyTeX, MiKTeX, or TeX Live distributions) is required. The
#' program further depends on `GhostScript`, which is usually not set on PATH
#' upon installation and you have to do it manually. The good news is that it
#' can be done straight from the R.
#'
#' @return No return value. Called for side effects.
#'
#' @importFrom tools find_gs_cmd
#' @importFrom usethis ui_todo ui_oops ui_field ui_code_block edit_r_environ
#'   ui_path
#' @export
#'
ensure_cropping <- function() {
  pdfcrop_absent <- !nzchar(Sys.which("pdfcrop"))
  gs_absent <- !nzchar(find_gs_cmd())

  if (pdfcrop_absent) {
    ui_oops("{ui_field('PDFCrop')} cannot be found. The easiest remedy is to install or reinstall {ui_field('tinytex')} package.")
  }

  if (gs_absent) {
    ui_oops("{ui_field('GhostScript')} cannot be found. Try following:")
    ui_todo(c(
      "Append following line to your {ui_field('.Renviron')} file.",
      "Replace the path {ui_path('C:/Program Files/gs/gs9.53.3/bin/gswin64c.exe')}",
      "with the path to the {ui_field('GhostScript')} on your system.",
      "Make sure to leave an empty line at the end."
    ))
    ui_code_block("R_GSCMD=\"C:/Program Files/gs/gs9.53.3/bin/gswin64c.exe\"")

    edit_r_environ()
  }
}


#' Basic Schola Empirica Word document
#'
#' This is a function called in the output of the YAML of the Rmd file to
#' specify using the standard Schola word document formatting.
#'
#' If no template is specified, the function will use the \code{reschola}'s
#' default template. Path to template is relative to document being compiled.
#' See the examples below, or read the
#' [`bookdown` manual](https://bookdown.org/yihui/rmarkdown-cookbook/word-template.html)
#' for more details and for a brief guide to Word templating).
#'
#' @param reference_docx Path to custom template. By default, the built-in one is used.
#' @inheritDotParams bookdown::word_document2
#'
#' @return A modified `word_document2` with the standard Schola formatting.
#' @family Report templates and formats
#' @author Petr Bouchal
#' @author Jan Netik
#'
#' @examples
#' \dontrun{
#' #  # with the default template
#' output:
#' reschola::schola_word
#'
#' # with a user-specified template
#' output:
#' reschola::schola_word:
#' reference_docx:template.docx
#' }
#' @export
schola_word <- function(reference_docx = find_resource("schola_word", "template.docx"), ...) {
  base <- bookdown::word_document2(reference_docx = reference_docx, ...)

  # proper quotes
  quotes_lua_filter <- system.file("pandoc", "pandoc-quotes.lua", package = "reschola")
  base$pandoc$lua_filters <- c(
    quotes_lua_filter,
    base$pandoc$lua_filters
  )

  # czech numbers
  base$knitr$knit_hooks$inline <- function(x) {
    if (!is.character(x)) {
      prettyNum(x, big.mark = " ", decimal.mark = ",")
    } else {
      x
    }
  }

  # nolint start
  base$knitr$opts_chunk$comment <- "#>"
  base$knitr$opts_chunk$message <- FALSE
  base$knitr$opts_chunk$warning <- FALSE
  base$knitr$opts_chunk$error <- FALSE
  base$knitr$opts_chunk$echo <- FALSE
  base$knitr$opts_chunk$cache <- FALSE
  base$knitr$opts_chunk$fig.width <- 6.29 # 15.98 cm i.e. 2 x 2.5 cm margins
  base$knitr$opts_chunk$dpi <- 300
  # base$knitr$opts_chunk$fig.retina <- 3
  base$knitr$opts_chunk$fig.asp <- .618 # default height is in golden ratio
  base$knitr$opts_chunk$fig.ext <- "png"
  base$knitr$opts_chunk$fig.path <- "figures/"
  # nolint end

  base
}



#' Schola Empirica Word document with customisable template
#'
#' @description
#' \lifecycle{deprecated}
#'
#' This is a function called in the output part of the YAML section of the Rmd
#' file while using the Word template provided at the same place (see example
#' below).
#'
#' @details Compared to `schola_word`, this "version" comes with no predefined
#' template, so the user can utilize a template stated in YAML header (see the
#' example below, or read the [`bookdown`
#' manual](https://bookdown.org/yihui/rmarkdown-cookbook/word-template.html) for
#' more details and for a brief guide to Word templating).
#'
#' @param ... Arguments to be passed to `[bookdown::word_document2]`
#'
#' @return A modified `word_document2` with the standard Schola formatting, but
#'   without hard-coded and unchangeable template.
#' @family Report templates and formats
#' @author Jan Netik
#' @export
#'
#' @importFrom lifecycle deprecate_warn
#'
#' @examples
#' \dontrun{
#' output:
#' reschola::schola_word2:
#' reference_docx:template.docx
#' }
schola_word2 <- function(...) {
  deprecate_warn("0.2.13", "reschola::schola_word2()", "reschola::schola_word()")

  base <- bookdown::word_document2(...)

  # nolint start
  base$knitr$opts_chunk$comment <- "#>"
  base$knitr$opts_chunk$message <- FALSE
  base$knitr$opts_chunk$warning <- FALSE
  base$knitr$opts_chunk$error <- FALSE
  base$knitr$opts_chunk$echo <- FALSE
  base$knitr$opts_chunk$cache <- FALSE
  base$knitr$opts_chunk$fig.width <- 6.29 # 15.98 cm i.e. 2 x 2.5 cm margins
  base$knitr$opts_chunk$dpi <- 300
  # base$knitr$opts_chunk$fig.retina <- 3
  base$knitr$opts_chunk$fig.asp <- .618 # default height is in golden ratio
  base$knitr$opts_chunk$fig.ext <- "png"
  base$knitr$opts_chunk$fig.path <- "figures/"
  # nolint end

  base
}
