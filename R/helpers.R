#' Create a Rmd doc using schola_word template
#'
#' Shortcut function to create and a new Rmd file using schola_word template and open for editing.
#'
#' @param name name to use for new file.
#' @param open whether to open file for editing, defaults to TRUE.
#'
#' @family Workflow helpers
#' @return path to created file (invisibly)
#' @examples
#' \dontrun{
#' draft_word("new_file")
#' }
#' @export
draft_word <- function(name = "draft.Rmd", open = T) {
  file <- suppressMessages(rmarkdown::draft(name, template = "schola_word", "reschola", edit = F))
  if (open) usethis::edit_file(file)
  invisible(name)
}
