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
#' @description
#' `r lifecycle::badge("questioning")`
#'
#' The function relies on `{extrafont}`
#' package that comes with briken dependencies at the moment. An experimental
#' `register_reschola_fonts()` is proposed.
#'
#' @details
#' This is an analogue of `hrbrthemes::import_roboto_condensed()`.
#'
#' There is an option `reschola.loadfonts` which -- if set to `TRUE` -- will
#' call `extrafont::loadfonts()` to register non-core fonts with R PDF &
#' PostScript devices. If you are running under Windows, the package calls the
#' same function to register non-core fonts with the Windows graphics device.
#'
#' @section Credits: Roboto is a trademark of Google.
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


#' Install reschola fonts on your computer
#'
#' @return Side effects.
#' @export
#'
#' @importFrom usethis ui_todo ui_info ui_field ui_path
#'
install_reschola_fonts <- function() {
  r_font_dir <- system.file("fonts", package = "reschola")

  ui_info("Opening {ui_path(r_font_dir)} with fonts...")
  system2("open", r_font_dir)

  ui_info("To install the fonts on Windows:")
  ui_todo("select all files in the directory which has been opened")
  ui_todo("right-click on them")
  ui_todo("chose {ui_field('Install for all users')} (requires admin rights)")
}

#' Register `{reschola}` fonts on Windows
#'
#' @description `r lifecycle::badge("experimental")`
#'
#'   This function is supposed to substitute `import_fonts()` as its
#'   dependencies are a bit buggy today and not updated often. **Not tested
#'   properly yet.**
#'
#' @details The function is only useful on Windows. On other platforms, fonts
#'   should be available out of the box for `Cairo` and/or `AGG` devices (which
#'   is recommended for PNG and other bitmap formats, see `{ragg}` package).
#'
#' @param family font family to register, default is reschola recommended
#'
#' @return Called for side effects.
#' @export
#' @importFrom grDevices windowsFont windowsFonts
#'
#' @family Font helpers and shortcuts
#'
register_reschola_fonts <- function(family = "Roboto Condensed") {

  # only for Windows bitmap devices, cairo and AGG can pick the font on its own
  args <- list()
  args[[family]] <- windowsFont(family)

  if (.Platform$OS.type != "windows") {
    stop("Only Windows is supported. On other systems, you should be fine out of the box.")
  }
  do.call(windowsFonts, args)
}


#' Make {ggplot2} use chosen font in geom_text/label
#'
#' Sets ggplot2 defaults for most text geoms from ggplot2, ggtext, and ggrepel.
#'
#' Geoms covered: "text", "label", "richtext", "text_box", "text_repel", "label_repel".
#'
#' @param family font family
#' @param face font face
#' @param size font size
#' @param color font color
#'
#' @importFrom purrr walk
#' @importFrom ggplot2 update_geom_defaults
#' @family Font helpers and shortcuts
#' @aliases set_reschola_ggplot_fonts
#' @export
#'
use_reschola_fonts <- function(family = "Roboto Condensed", face = "plain",
                               size = 3.5, color = "#2b2b2b") {
  available_namespaces <- sapply(
    c("ggplot2", "ggtext", "ggrepel"),
    function(.x) requireNamespace(.x, quietly = TRUE)
  )

  geoms <- list(
    ggplot2 = c("text", "label"),
    ggtext = c("richtext", "text_box"),
    ggrepel = c("text_repel", "label_repel")
  )

  geoms <- unlist(geoms[names(which(available_namespaces))])

  walk(
    geoms,
    ~ update_geom_defaults(
      .x,
      list(family = family, face = face, size = size, color = color)
    )
  )
}


#' @rdname use_reschola_fonts
#' @export
set_reschola_ggplot_fonts <- function(family = "Roboto Condensed", face = "plain",
                                      size = 3.5, color = "#2b2b2b") {
  use_reschola_fonts(family = family, face = face, size = size, color = color)
}
