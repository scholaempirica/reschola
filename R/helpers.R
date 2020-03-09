#' Create a Rmd doc using schola_word template
#'
#' Shortcut function to create and a new Rmd file using schola_word template and open for editing.
#'
#' @param name name to use for new file.
#' @param open whether to open file for editing, defaults to TRUE.
#'
#' @examples
#' \dontrun{
#'   create_word("new_file")
#' }
#' @export
create_word <- function(name = "draft.Rmd", open = T) {
  file <- rmarkdown::draft(name, template = "schola_word", "reschola", edit = F)
  if(open) usethis:::edit_file(file)
  return(TRUE)
}

create_redoc <- function(name = "draft.Rmd", open = T) {
  file <- rmarkdown::draft(name, template = "schola_redoc", "reschola", edit = F)
  if(open) usethis:::edit_file(file)
  return(TRUE)
}
