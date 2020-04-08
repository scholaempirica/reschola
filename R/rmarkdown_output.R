#' Basic Schola Empirica word document
#'
#' This is a function called in the output of the yaml of the Rmd file to
#' specify using the standard Schola word document formatting.
#'
#' @param ... Arguments to be passed to `[bookdown::word_document2]`
#'
#' @return A modified `word_document2` with the standard Schola formatting.
#' @family Report templates and formats
#' @export
#'
#' @examples
#' \donttest{
#'   output: reschola::schola_word
#' }
schola_word <- function(...) {
  template <- find_resource("schola_word", "template.docx")
  base <- bookdown::word_document2(reference_docx = template, ...)

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
#' \donttest{
#'   output: reschola::schola_redoc
#' }
schola_redoc <- function(...) {
  template <- find_resource("schola_word", "template.docx")
  base <- redoc::redoc(reference_docx = template,
                       ...)

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

