#' Create a Rmd doc using schola_word template
#'
#' Shortcut function to create and a new Rmd file using schola_word template and open for editing.
#'
#' @param name name to use for new file.
#' @param open whether to open file for editing, defaults to TRUE.
#'
#' @examples
#' @family Report templates and formats
#' \dontrun{
#' draft_word("new_file")
#' }
#' @export
draft_word <- function(name = "draft.Rmd", open = T) {
  file <- rmarkdown::draft(name, template = "schola_word", "reschola", edit = F)
  if (open) usethis:::edit_file(file)
  return(TRUE)
}

#' Create a Rmd doc for reversible reviewing using schola_redoc template
#'
#' Shortcut function to create and a new Rmd file using schola_redoc template and open for editing.
#'
#' @param name name to use for new file.
#' @param open whether to open file for editing, defaults to TRUE.
#'
#' @family Report templates and formats
#' @examples
#' \dontrun{
#' draft_word("new_file")
#' }
#' @export
draft_redoc <- function(name = "draft.Rmd", open = T) {
  file <- rmarkdown::draft(name, template = "schola_redoc", "reschola", edit = F)
  if (open) usethis:::edit_file(file)
  return(TRUE)
}
