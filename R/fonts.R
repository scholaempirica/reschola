## adapted from ratlas

#' @importFrom hrbrthemes font_rc
#' @export
hrbrthemes::font_rc
#' @importFrom hrbrthemes font_rc
#' @export
hrbrthemes::font_rc_light

#' @importFrom hrbrthemes update_geom_font_defaults
#' @export
hrbrthemes::update_geom_font_defaults

font_rc_bold <- "Roboto Condensed Bold"
font_rc_thin <- "Roboto Condensed Thin"
font_rc_light <- "Roboto Condensed Light"
font_r_bold <- "Roboto Bold"
font_r_thin <- "Roboto Thin"
font_r <- "Roboto"
font_r_light <- "Roboto Light"

#' Import Roboto Condensed font for use in charts
#'
#' Roboto is a trademark of Google.
#'
#' There is an option `reschola.loadfonts` which -- if set to `TRUE` -- will
#' call `extrafont::loadfonts()` to register non-core fonts with R PDF & PostScript
#' devices. If you are running under Windows, the package calls the same function
#' to register non-core fonts with the Windows graphics device.
#'
#' @md
#' @note This will take care of ensuring PDF/PostScript usage. The location of the
#'   font directory is displayed after the base import is complete. It is highly
#'   recommended that you install them on your system the same way you would any
#'   other font you wish to use in other programs.
#' @export
import_roboto <- function() {

  r_font_dir <- system.file("fonts", "roboto", package="reschola")

  suppressWarnings(suppressMessages(extrafont::font_import(r_font_dir, prompt=FALSE)))

  message(
    sprintf(
      "You will likely need to install these fonts on your system as well.\n\nYou can find them in [%s]",
      r_font_dir)
  )

}


#' Import fonts needed for theme_schola defaults
#'
#' Imports Roboto and Roboto Condensed. Draws on the hrbrthemes package.
#'
#' @export
#'
import_fonts <- function() {
  import_roboto()
  hrbrthemes::import_roboto_condensed()
}


#' Mqke ggplot2 use chosen font in geom_text/label
#'
#' Wrapper around update_geom_font_defaults(), different default
#'
#' @param font font, defaults to `"Roboto Condensed"`
#' @export
#'
set_reschola_ggplot_fonts <- function(font = "Roboto Condensed") {
  update_geom_font_defaults(font)
}