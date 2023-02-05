#' Create a `.Rmd` draft using Schola templates
#'
#' Shortcut function to create a new `.Rmd` file using Schola standard templates
#' and open it for editing.
#'
#' @param name *character*, name to use for new file. With or without file extension.
#' @param open *logical*, whether to open file for editing, defaults to TRUE.
#'
#' @family Workflow helpers
#' @return Path to the created file (invisibly).
#'
#' @importFrom usethis edit_file
#' @importFrom rmarkdown draft
#'
#' @examples
#' \dontrun{
#' draft_pdf("best_report")
#' }
#'
#' @rdname draft
#' @export
draft_pdf <- function(name = "pdf_draft", open = TRUE) {
  # note that occasionally, rmarkdown::draft is unable to locate templates
  # inside package - it happened to me once, but don't know why, should not
  # affect end users not playing with the package
  file <- suppressMessages(
    draft(name, template = "schola_pdf", package = "reschola", edit = FALSE)
  )
  if (open) edit_file(file)
  invisible(name)
}

#' @rdname draft
#' @export
draft_word <- function(name = "word_draft", open = TRUE) {
  file <- suppressMessages(
    draft(name, template = "schola_word", package = "reschola", edit = FALSE)
  )
  if (open) edit_file(file)
  invisible(name)
}
