# Helper functions from bookdown and rticles -----------------------------------
# copied from https://github.com/atlas-aai/ratlas/

find_file <- function(template, file) {
  template <- system.file("rmarkdown", "templates", template, file,
    package = "reschola"
  )
  if (template == "") {
    stop("Couldn't find template file ", template, "/", file, call. = FALSE)
  }

  template
}

find_resource <- function(template, file) {
  find_file(template, file.path("resources", file))
}

#' Locate and open default Schola templates
#'
#' Open the default Schola templates used by [`schola_word()`], or
#' [`schola_pdf()`] (specify with `format` argument). The templates are shipped
#' with the package and are somewhat hidden in `R` library, so this auxiliary
#' function can help you dig them up.
#'
#' You can either edit the chosen template directly in its natural habitat
#' (questionable short-term solution), or better -- use "Save as" option and
#' keep it and use it within the project directory.
#'
#' @param format *Character*, format which to look for. Defaults to `pdf`.
#'
#' @return No return value, called for side effect.
#' @family Report templates and formats
#' @author Jan Netik
#' @export
#'
#' @examples
#' \dontrun{
#' open_schola_template()
#' }
open_schola_template <- function(format = "pdf") {
  switch(format,
    word = system2("open", find_resource("schola_word", "template.docx")),
    pdf = system2("open", find_resource("schola_pdf", "schola_template.tex"))
  )
}

reschola_file <- function(...) {
  system.file(..., package = "reschola", mustWork = TRUE)
}

#' Copy default Schola template into project directory
#'
#' @param format *Character*, format which to look for. Defaults to `pdf`.
#' @param path *Character*, path to copy to. Defaults to the current project
#'   root.
#' @inheritDotParams base::file.copy -from -to
#'
#' @return No return value, called for side effect.
#' @family Report templates and formats
#' @author Jan Netik
#'
#' @importFrom usethis proj_get
#' @export
#'
#' @examples
#' \dontrun{
#' copy_schola_template()
#' }
copy_schola_template <- function(format = "pdf", path = proj_get(), ...) {
  switch(format,
    word = invisible(file.copy(find_resource("schola_word", "template.docx"), path, ...)),
    docx = invisible(file.copy(find_resource("schola_word", "template.docx"), path, ...)),
    pdf = invisible(file.copy(find_resource("schola_pdf", "schola_template.tex"), path, ...))
  )
}

reschola_file <- function(...) {
  system.file(..., package = "reschola", mustWork = TRUE)
}
