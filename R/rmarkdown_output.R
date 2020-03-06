#' Basic Schola Empirica word document
#'
#' This is a function called in the output of the yaml of the Rmd file to
#' specify using the standard Schola word document formatting.
#'
#' @param ... Arguments to be passed to `[bookdown::word_document2]`
#'
#' @return A modified `word_document2` with the standard Schola formatting.
#' @export
#'
#' @examples
#' \dontrun{
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
  base$knitr$opts_chunk$fig.width <- 8
  # base$knitr$opts_chunk$fig.asp <- 0.618
  base$knitr$opts_chunk$fig.ext <- "png"
  base$knitr$opts_chunk$fig.retina <- 3
  base$knitr$opts_chunk$fig.path <- "figures/"
  # base$knitr$opts_chunk$fig.pos <- "H"
  # nolint end

  base
}

