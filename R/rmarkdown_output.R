
#' Basic Schola Empirica PDF document
#'
#' This is a function called in the output of the YAML of the Rmd file to
#' specify using the standard Schola PDF document formatting.
#'
#' @inheritDotParams bookdown::pdf_document2
#'
#' @return A modified `pdf_document2` with the standard Schola formatting.
#' @author Jan Netik
#'
#' @examples
#' \dontrun{
#' output:
#'   reschola::schola_pdf:
#'     toc: no
#' }
#' @family Report templates and formats
#'
#' @importFrom bookdown pdf_document2
#' @export
#'
schola_pdf <- function(num_format = "cs", ...) {
  base <- pdf_document2(...)

  # GS needed to crop figures
  # Sys.setenv(R_GSCMD="C:/Program Files/gs/gs9.53.3/bin/gswin64c.exe")

  # force plot cropping (see https://github.com/rstudio/rmarkdown/issues/2016)
  base$knitr$knit_hooks$crop <- knitr::hook_pdfcrop
  base$knitr$opts_chunk$crop <- TRUE

  # replaces plain quotation marks with typographic ones
  quotes_lua_filter <- system.file("pandoc", "pandoc-quotes.lua", package = "reschola")
  base$pandoc$lua_filters <- c(
    quotes_lua_filter,
    base$pandoc$lua_filters
  )

  # czech numbers
  if (num_format == "cs") {
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
  base$knitr$opts_chunk$fig.width <- 6.29 # 15.98 cm i.e. 2 x 2.5 cm margins, or possibly "\\textwidth"
  base$knitr$opts_chunk$dev <- "cairo_pdf" # for support of non-ASCII chars, namely
  base$knitr$opts_chunk$fig.asp <- .618 # golden ratio
  base$knitr$opts_chunk$fig.path <- "figs/" # if Ghostscript and pdfcrop are avaiable, they are cropped
  base$knitr$opts_chunk$fig.align <- "center"
  # nolint end

  base
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
#' @examples
#' \dontrun{
#' output:
#' reschola::schola_word2:
#' reference_docx:template.docx
#' }
schola_word2 <- function(...) {
  lifecycle::deprecate_warn("0.2.13", "reschola::schola_word2()", "reschola::schola_word()")

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


#' Reversible Schola Empirica word document
#'
#' This is a function called in the output of the yaml of the Rmd file to
#' provide "reversible markdown-Word collaboration" as devised by `redoc`,
#' while using the standard Schola word document formatting.
#' See the [redoc documentation](https://noamross.github.io/redoc/) for a how to
#' on the reversible editing.
#'
#' The capabilities of this format are a bit more limited compared to `schola_word`.
#'
#' @param ... Arguments to be passed to `[redoc::redoc]` and secondarily to
#' `word_document`.
#'
#' @return A modified `redoc` with the standard Schola formatting.
#' @family Report templates and formats
#' @export
#'
#' @examples
#' \dontrun{
#' output:reschola::schola_redoc
#' }
schola_redoc <- function(...) {
  template <- find_resource("schola_word", "template.docx")
  base <- redoc::redoc(
    reference_docx = template,
    ...
  )

  # nolint start
  base$knitr$opts_chunk$comment <- "#>"
  base$knitr$opts_chunk$message <- FALSE
  base$knitr$opts_chunk$warning <- FALSE
  base$knitr$opts_chunk$error <- FALSE
  base$knitr$opts_chunk$echo <- FALSE
  base$knitr$opts_chunk$cache <- FALSE
  base$knitr$opts_chunk$fig.width <- 6.69 # 17 cm i.e. 2 x 2 cm margins
  base$knitr$opts_chunk$dpi <- 300 # will in reality be 300 so good for printing
  # base$knitr$opts_chunk$fig.retina <- 2
  base$knitr$opts_chunk$fig.asp <- .6 # default height is .6 times width
  base$knitr$opts_chunk$fig.ext <- "png"
  base$knitr$opts_chunk$fig.path <- "figures/"
  # this to solve this issue: https://github.com/noamross/redoc/issues/63
  base$knitr$knit_hooks$plot <- knitr:::hook_plot_md_pandoc
  # nolint end

  base
}
