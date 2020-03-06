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

reschola_file <- function(...) {
  system.file(..., package = "reschola", mustWork = TRUE)
}
