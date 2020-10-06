# Helper functions from bookdown and rticles -----------------------------------
# copied from https://github.com/atlas-aai/ratlas/

find_file <- function(template, file) {
  template <- system.file("rmarkdown", "templates", template, file,
                          package = "reschola")
  if (template == "") {
    stop("Couldn't find template file ", template, "/", file, call. = FALSE)
  }

  template
}

find_resource <- function(template, file) {
  find_file(template, file.path("resources", file))
}

#' Locate and open default Word template
#'
#' Open the default Word template used by `schola_word`.
#' The template comes with the package and is somewhat hidden in R library,
#' so this auxiliary function can help you dig it up.
#'
#' You can either edit the template directly (see [schola_word2] for more detail) and save it, or better -
#' use "Save as" option and keep it within the project directory, as described in [schola_word2].
#'
#' @usage open_schola_word_template()
#'
#' @return No return value, called for side effect.
#' @family Report templates and formats
#' @author Jan Netik
#' @export
#'
#' @examples
#' \dontrun{open_schola_word_template()}
open_schola_word_template <- function() {
  system2("open", find_resource("schola_word", "template.docx"))
}

reschola_file <- function(...) {
  system.file(..., package = "reschola", mustWork = TRUE)
}
