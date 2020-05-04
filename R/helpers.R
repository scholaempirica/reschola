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

#' Create a Rmd doc for reversible reviewing using schola_redoc template
#'
#' Shortcut function to create and a new Rmd file using schola_redoc template and open for editing.
#'
#' @param name name to use for new file.
#' @param open whether to open file for editing, defaults to TRUE.
#'
#' @family Workflow helpers
#' @return path to created file (invisibly)
#' @examples
#' \dontrun{
#' draft_redoc("new_file")
#' }
#' @export
# draft_redoc <- function(name = "draft.Rmd", open = T) {
#   file <-  rmarkdown::draft(name, template = "schola_redoc", "reschola", edit = F)
#   if(rstudioapi::isAvailable() & open) {
#     suppressMessages(usethis::edit_file(file))
#     usethis::ui_todo("Just a second while I prepare the file for reproducible collaboration with MS Word...")
#     redoc::roundtrip_active_file()
#     usethis::ui_done("Done. You can now edit the file. See the 'workflow' vignette for guidance.")
#   } else {
#     usethis::ui_done("File {usethis::ui_path('name')} created.")
#     usethis::ui_todo("You might want to roundtrip the file by running {usethis::ui_code(paste0('rmarkdown::render(\"',name,'.Rmd\")'))} and {usethis::ui_code(paste0('redoc::dedoc(\"',name,'.Rmd\")'))} before editing.
#                           See the 'workflow' vignette for guidance on reproducible collaboration with MS Word.")
#   }
#   invisible(TRUE)
# }
draft_redoc <- function(name = "draft.Rmd", open = T) {
  file <-  rmarkdown::draft(name, template = "schola_redoc", "reschola", edit = F)
  usethis::ui_info("Roundtripping file for smoother editing...")
  file_rendered <- suppressMessages(rmarkdown::render(file, quiet = T, output_dir = tempdir(),
                                                      output_format = schola_redoc(),
                                                      clean = T))
  file_new <- redoc::redoc_extract_rmd(file_rendered, type = "roundtrip", dir = tempdir(), overwrite = T)
  fs::file_copy(file_new, file, overwrite = T)
  if(open) {
    suppressMessages(usethis::edit_file(file))
    usethis::ui_done("File open for editing.
                     See {usethis::ui_code('vignette(\\'workflow\\')')} for guidance on how to use this.
                     Or go to {usethis::ui_path('https://scholaempirica.github.io/articles/workflow.html.')}")
  } else {
    usethis::ui_done("File {usethis::ui_path(file)} ready to be edited.
                     See {usethis::ui_code('vignette(\\'workflow\\')')} for guidance on how to use this.
                     Or go to {usethis::ui_path('https://scholaempirica.github.io/articles/workflow.html.')}")
    }
  invisible(file)
}
