## adapted from ratlas and hrbrthemes

#' @importFrom hrbrthemes update_geom_font_defaults
#' @export
hrbrthemes::update_geom_font_defaults

#' @rdname Roboto
#' @md
#' @description `font_rc` == "`Roboto Condensed`"
#' @export
font_rc <- "Roboto Condensed"

#' @rdname Roboto
#' @md
#' @description `font_rc_bold` == "`Roboto Condensed Bold`"
#' @export
font_rc_bold <- "Roboto Condensed Bold"

#' @rdname Roboto
#' @md
#' @description `font_rc_thin` == "`Roboto Condensed Thin`"
#' @export
font_rc_thin <- "Roboto Condensed Thin"

#' @rdname Roboto
#' @md
#' @note `font_rc_light` (a.k.a. "`Roboto Condensed Light`") is not available on
#'     Windows and will throw a warning if used in plots.
#' @description `font_rc_light` == "`Roboto Condensed Light`"
font_rc_light <- "Roboto Condensed Light"

#' Roboto font shortcuts
#' @rdname Roboto
#' @md
#' @description `font_bold` == "`Roboto Bold`"
#' @export
font_r_bold <- "Roboto Bold"

#' @rdname Roboto
#' @md
#' @description `font_rc_thin` == "`Roboto Thin`"
#' @export
font_r_thin <- "Roboto Thin"

#' @rdname Roboto
#' @md
#' @description `font_r` == "`Roboto`"
#' @export
font_r <- "Roboto"

#' @rdname Roboto
#' @md
#' @note `font_r_light` (a.k.a. "`Roboto Light`") is not available on
#'     Windows and will throw a warning if used in plots.
#' @description `font_fc_light` == "`Roboto Light`"
#' @export
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
