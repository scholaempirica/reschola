.onAttach <- function(libname, pkgname) {

  # adapted from hrbrthemes

  # Suggestion by @alexwhan


  if (.Platform$OS.type == "windows")  { # nocov start
    # fix as per https://github.com/wch/extrafont/issues/44#issue-comment-box
    windowsFonts <- grDevices::windowsFonts
    if (interactive()) packageStartupMessage("Registering Windows fonts with R")
    extrafont::loadfonts("win", quiet = TRUE)
  }

  if (getOption("reschola.loadfonts", default = FALSE)) {
    if (interactive()) packageStartupMessage("Registering PDF & PostScript fonts with R")
    # fix as per https://github.com/wch/extrafont/issues/44#issue-comment-box
    pdfFonts <- grDevices::pdfFonts
    postscriptFonts <- grDevices::postscriptFonts
    extrafont::loadfonts("pdf", quiet = TRUE)
    extrafont::loadfonts("postscript", quiet = TRUE)
  }

  if (!any(grepl("Roboto|Roboto[ ]Condensed", extrafont::fonts()))) {
    packageStartupMessage("NOTE: Roboto and Roboto Condensed fonts are required for the default setting of theme_schola() to work.")
    packageStartupMessage("      Please use reschola::import_fonts() to install Roboto and Roboto Condensed")
  } # nocov end

}
