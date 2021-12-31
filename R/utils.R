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



#' Get RDS from custom dir
#'
#' @param file  file to make, rds fileext is appended automatically or forced if
#'   other ext is provided
#' @param type type of data, dir inside data_dir
#'
#' @keywords internal
#'
#' @importFrom fs path_ext_set
#' @importFrom here here
#' @importFrom readr read_rds
#'
get_data <- function(file, type, data_dir = "data") {
  path <- here(data_dir, type, file)
  read_rds(path_ext_set(path, "rds"))
}

#' Write RDS to custom dir
#'
#' @param .data an object to save as RDS
#' @param file file to make, rds fileext is appended automatically or forced if
#'   other ext is provided
#' @param type type of data, dir inside data_dir
#' @param data_dir dir with data dirs
#'
#' @keywords internal
#'
#' @importFrom fs path_ext_set
#' @importFrom here here
#' @importFrom readr write_rds
#'
write_data <- function(.data, file, type, data_dir = "data") {
  path <- here(data_dir, type, file)
  path <- path_ext_set(path, "rds")
  write_rds(.data, path)

  invisible(path)
}


#' Quick access to data in standard `reschola` project
#'
#' Note that file paths are handled with `here()` already.
#'
#' @param file *character*, file name to get or write to, `.rds` is appended
#'   automatically if not already provided.
#' @param .data *data object* to save as RDS.
#'
#' @returns
#' - `get_*` returns object(s) in the `.rds` being read
#' - `write_*` returns a `fs_path` path of `.rds` file being created invisibly
#'
#' @export
#' @rdname schola_rds
get_input_data <- function(file) {
  get_data(file, type = "input")
}

#' @export
#' @rdname schola_rds
get_intermediate_data <- function(file) {
  get_data(file, type = "intermediate")
}

#' @export
#' @rdname schola_rds
get_processed_data <- function(file) {
  get_data(file, type = "processed")
}

#' @export
#' @rdname schola_rds
write_input_data <- function(.data, file) {
  write_data(.data, file, type = "input")
}

#' @export
#' @rdname schola_rds
write_intermediate_data <- function(.data, file) {
  write_data(.data, file, type = "intermediate")
}

#' @export
#' @rdname schola_rds
write_processed_data <- function(.data, file) {
  write_data(.data, file, type = "processed")
}



#' Get current reschola project Google Drive URL ID
#'
#' Gets a hidden object `.gd_proj_url` (by default) created at project
#' "startup". See the details below for reschola projects created prior reschola
#' version 0.4.0.
#'
#' @section Legacy usage prior to \{reschola\} version 0.4.0:
#'    Call `usethis::edit_r_profile(scope = "project")` and write (note the dot
#'    prefix):
#'
#'   ```
#'   .gd_proj_url <- "your_google_drive_url"
#'   ```
#'
#'   Note that **you have to restart your R session to apply any changes**. Note
#'   also that **the URL cannot contain any query** (parts with a leading
#'   question mark), i.e. `?usp=sharing`.
#'
#' @param url_object *character*, name of the object URL is stored in.
#'   `.gd_proj_url` by default.
#' @return A character vector of class `drive_id`.
#'
#' @export
#' @importFrom googledrive as_id
#' @importFrom rlang abort
#' @importFrom usethis ui_todo ui_field ui_code
#'
gd_get_proj <- function(url_object = ".gd_proj_url") {
  if (!is.null(res <- get0(url_object, envir = .GlobalEnv))) {
    return(as_id(res))
  }
  on.exit(ui_todo(
    "Call {ui_code('usethis::edit_r_profile(scope = \"project\")')} and set the URL to {ui_field({url_object})}."
  ))
  abort("Google Drive URL not set!")
}


#' Convert color to hexadecimal format
#'
#' @param color *character*, color name (seel `colors()` for recognized values)
#' @param alpha *numeric*, opacity in interval 0--1, where 1 is no transparency,
#'   i.e. full opacity
#'
#' @return *character*, color in hexadecimal format
#' @keywords internal
#'
#' @examples
#' clr2hex("red")
clr2hex <- function(color, alpha = 1) {
  if (grepl("^#[a-fA-F0-9]{6,8}$", color)) {
    return(color)
  }
  rgb_col <- col2rgb(color) / 255
  apply(rgb_col, 2, function(x) rgb(x[1L], x[2L], x[3L], alpha))
}

#' Create HTML span tag with text and color style
#'
#' @param text *character*, text that will be colored.
#' @param color *character*, color applied to the text, defaults to black.
#' @param alpha *numeric*, opacity in interval 0--1, where 1 is no transparency,
#'   i.e. full opacity
#' @inheritDotParams htmltools::span
#'
#' @return an object of class `shiny.tag`, coercible to character
#'
#' @export
#' @importFrom htmltools span
#'
#' @examples
#' html <- paste0(
#'   with_clr("Red", "red"), ", ",
#'   with_clr("green", "green"),
#'   " and ",
#'   with_clr("blue", "blue"),
#'   " are the basic colors."
#'   )
#'
#' library(ggplot2)
#' library(ggtext)
#'
#' ggplot() +
#'   geom_richtext(aes(x = 1, y = 1, label = html), size = 8) +
#'   theme_void()

with_clr <- function(text, color = "black", alpha = 1, ...) {
  span(text,
    style = paste("color:", clr2hex(color, alpha = alpha)), ...
  )
}



#' Transform to STEN score (Standard Ten)
#'
#' Get your raw total score transformed to stens, i.e., with the mean of 5.5 and
#' a standard deviation of 2. See the [Wikipedia
#' article](https://en.wikipedia.org/wiki/Sten_scores) on the topic for more
#' details.
#'
#' @param score *numeric* vector of scores to transform
#' @param standardize *logical*, center and scale `score` vector before the
#'   transformation? Defaults to `FALSE`.
#'
#' @return
#' @export
#'
#' @examples
#' rnorm(10) %>% sten()
sten <- function(score, standardize = FALSE) {
  if (standardize) score <- as.numeric(scale(score))
  (score * 2) + 5.5
}
