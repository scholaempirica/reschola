.onAttach <- function(libname, pkgname) {

  # adapted from hrbrthemes

  # Suggestion by @alexwhan

  if (.Platform$OS.type == "windows")  { # nocov start
    if (interactive()) packageStartupMessage("Registering Windows fonts with R")
    extrafont::loadfonts("win", quiet = TRUE)
  }

  if (getOption("reschola.loadfonts", default = FALSE)) {
    if (interactive()) packageStartupMessage("Registering PDF & PostScript fonts with R")
    extrafont::loadfonts("pdf", quiet = TRUE)
    extrafont::loadfonts("postscript", quiet = TRUE)
  }

  fnt <- extrafont::fonttable()
  if (!any(grepl("Roboto|Roboto[ ]Condensed", fnt$FamilyName))) {
    packageStartupMessage("NOTE: Roboto and Roboto Condensed fonts are required to use the default setting of theme_schola().")
    packageStartupMessage("      Please use reschola::import_fonts() to install Roboto and Roboto Condensed")
  } # nocov end

}