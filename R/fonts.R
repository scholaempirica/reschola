## adapted from ratlas and hrbrthemes

#' @rdname Roboto
#' @md
#' @description `font_rc` == "`Roboto Condensed`"
#' @family Font helpers and shortcuts
#' @export
font_rc <- "Roboto Condensed"

#' @rdname Roboto
#' @md
#' @description `font_rc_bold` == "`Roboto Condensed Bold`"
#' @family Font helpers and shortcuts
#' @export
font_rc_bold <- "Roboto Condensed Bold"

#' @rdname Roboto
#' @md
#' @description `font_rc_thin` == "`Roboto Condensed Thin`"
#' @family Font helpers and shortcuts
#' @export
font_rc_thin <- "Roboto Condensed Thin"

#' @rdname Roboto
#' @md
#' @note `font_rc_light` (a.k.a. "`Roboto Condensed Light`") is not available on
#'   Windows and will throw a warning if used in plots.
#' @family Font helpers and shortcuts
#' @description `font_rc_light` == "`Roboto Condensed Light`"
font_rc_light <- "Roboto Condensed Light"

#' Roboto font shortcuts
#' @rdname Roboto
#' @md
#' @description `font_bold` == "`Roboto Bold`"
#' @family Font helpers and shortcuts
#' @export
font_r_bold <- "Roboto Bold"

#' @rdname Roboto
#' @md
#' @description `font_rc_thin` == "`Roboto Thin`"
#' @family Font helpers and shortcuts
#' @export
font_r_thin <- "Roboto Thin"

#' @rdname Roboto
#' @md
#' @description `font_r` == "`Roboto`"
#' @family Font helpers and shortcuts
#' @export
font_r <- "Roboto"

#' @rdname Roboto
#' @md
#' @note `font_r_light` (a.k.a. "`Roboto Light`") is not available on
#'     Windows and will throw a warning if used in plots.
#' @description `font_fc_light` == "`Roboto Light`"
#' @family Font helpers and shortcuts
#' @export
font_r_light <- "Roboto Light"



#' Import Roboto fonts for use in charts and in the PDF reports
#'
#' Roboto is a trademark of Google.
#'
#' This is an analogue of `hrbrthemes::import_roboto_condensed()`.
#'
#' There is an option `reschola.loadfonts` which -- if set to `TRUE` -- will
#' call `extrafont::loadfonts()` to register non-core fonts with R PDF &
#' PostScript devices. If you are running under Windows, the package calls the
#' same function to register non-core fonts with the Windows graphics device.
#'
#' @note If you install the fonts just for the current user (via right-click and
#'   Install), they will probably **not be discoverable** by the `fontspec`
#'   LaTeX package that is used for PDF report typesetting!
#'
#' @family Font helpers and shortcuts
#'
#' @importFrom usethis ui_done ui_todo ui_info ui_field ui_path ui_oops
#'   ui_code_block ui_value ui_code
#' @importFrom extrafont font_import fonts
#' @importFrom rlang abort
#'
#' @export
import_fonts <- function() {
  r_font_dir <- system.file("fonts", package = "reschola")

  ui_info("You are about to register Roboto fonts with R. This may take some time. Please, be patient.")

  suppressWarnings(suppressMessages(font_import(r_font_dir, prompt = FALSE)))

  if (!any(grepl("Roboto|Roboto[ ]Condensed", fonts()))) {
    on.exit({
      ui_todo("You can inspect the fonts that are properly registered by calling {ui_code(\"extrafont::fonts()\")}.")
      ui_info("If the registration fails repeatedly, please try to downgrade {ui_value(\"Rttf2pt1\")} package to version {ui_value(\"1.3.8\")}:")
      suppressWarnings(ui_code_block("remotes::install_version(\"Rttf2pt1\", version = \"1.3.8\")"))
    })
    abort("At least one of the fonts needed by the package was not registered succesfully.")
  }

  ui_done("Fonts successfully registered in R.")
  ui_info("Opening {ui_path(r_font_dir)} with fonts...")
  system2("open", r_font_dir)

  ui_info("To install the fonts on Windows:")
  ui_todo("select all files in the directory which has been opened")
  ui_todo("right-click on them")
  ui_todo("chose {ui_field('Install for all users')} (requires admin rights)")
}


#' Mqke ggplot2 use chosen font in geom_text/label
#'
#' Wrapper around update_geom_font_defaults(), different default
#'
#' @param font font, defaults to `"Roboto Condensed"`
#'
#' @importFrom hrbrthemes update_geom_font_defaults
#' @family Font helpers and shortcuts
#' @export
#'
set_reschola_ggplot_fonts <- function(font = "Roboto Condensed") {
  update_geom_font_defaults(font)
}
