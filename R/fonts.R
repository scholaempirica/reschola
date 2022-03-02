
#' Import Ubuntu fonts for use in charts and in the PDF reports
#'
#' @description
#' `r lifecycle::badge("deprecated")`
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
#' @source Fonts are licensed under the [Ubuntu Font License](https://ubuntu.com/legal/font-licence).
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

  ui_info("You are about to register Ubuntu fonts with R. This may take some time. Please, be patient.")

  suppressWarnings(suppressMessages(font_import(r_font_dir, prompt = FALSE)))

  if (!any(grepl("Ubuntu|Ubuntu[ ]Condensed", fonts()))) {
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
#' Just a simple wizard.
#'
#' @return Side effects.
#' @family Font helpers and shortcuts
#' @export
#'
#' @importFrom usethis ui_todo ui_info ui_field ui_path
#'
install_reschola_fonts <- function() {
  r_font_dir <- system.file("fonts", package = "reschola")
  if (.Platform$OS.type == "windows") {
    ui_info("Opening {ui_path(r_font_dir)} with fonts...")
    system2("open", r_font_dir) # seems to work only on Windows and MacOS

    ui_info("To install the fonts on Windows:")
    ui_todo("select all files in the directory which has been opened")
    ui_todo("right-click on them")
    ui_todo("chose {ui_field('Install for all users')} (requires admin rights)")
  } else {
    ui_info(c(
      "Only Windows is supported at the moment.",
      "Font files for manual installation are available in",
      "{ui_path(r_font_dir)}"
    ))
  }
}

#' Register reschola fonts on Windows
#'
#' @description `r lifecycle::badge("stable")`
#'
#'   The function is only for Windows, where it tries to register font family
#'   provided with "Windows bitmap device". On other platforms, fonts *should*
#'   be readily available after installation. Note that even on Windows, you can
#'   instruct RStudio to use smarter graphics device, such as "AGG" or "Cairo"
#'   (*Tools > Global Options > General > Graphics > Backend*).
#'
#' @param family font family/families to register, default is reschola
#'   recommended.
#'
#' @return Called for side effects, but returns logical on process result
#'   invisibly.
#' @export
#'
#' @family Font helpers and shortcuts
#'
register_reschola_fonts <- function(family = c("Ubuntu", "Ubuntu Condensed")) {

  # only for Windows bitmap devices, cairo and AGG can pick the font on its own
  if (.Platform$OS.type == "windows") {
    args <- list()

    for (font in family) args[[font]] <- grDevices::windowsFont(font)
    do.call(grDevices::windowsFonts, args)

    message("Done registering fonts with Windows bitmap devices...")
    invisible(TRUE)
  } else {
    invisible(FALSE)
  }
}


#' Make ggplot2 use font(s) in text-based geoms
#'
#' Sets `{ggplot2}` defaults for most text-based geoms in `{ggplot2}`,
#' `{ggtext}`, and `{ggrepel}`.
#'
#' Geoms covered: "text", "label", "richtext", "text_box", "text_repel", and
#' "label_repel".
#'
#' @param family font family, defaults to reschola recommended
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
use_reschola_fonts <- function(family = "Ubuntu Condensed", face = "plain",
                               size = 3.5, color = "#2b2b2b") {
  walk(
    c("text", "label", "richtext", "text_box", "text_repel", "label_repel"),
    ~ try(update_geom_defaults(
      .x,
      list(family = family, face = face, size = size, color = color)
    ), silent = TRUE)
  )
}


#' @rdname use_reschola_fonts
#' @export
set_reschola_ggplot_fonts <- function(family = "Ubuntu Condensed", face = "plain",
                                      size = 3.5, color = "#2b2b2b") {
  use_reschola_fonts(family = family, face = face, size = size, color = color)
}
