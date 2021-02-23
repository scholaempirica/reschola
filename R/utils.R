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
#' \dontrun{
#' open_schola_word_template()
#' }
open_schola_word_template <- function() {
  system2("open", find_resource("schola_word", "template.docx"))
}

reschola_file <- function(...) {
  system.file(..., package = "reschola", mustWork = TRUE)
}




#' Make Date of Class `czech_date`
#'
#' Appends the `czech_date` class attribute to the input object. Date of class
#' `czech_date` is printed as a date in long format with correct Czech
#' grammatical case (see Details and Grammatical cases section below).
#'
#' The grammatical case *should* be specified as and argument to `print()`
#' method, but for convenience, you can predefine it in `as_czech_date` call
#' directly. It is then stored as an attribute, later grabbed by the `print`
#' method.
#'
#' Note that as opposed to other date formating functions in `R`,
#' `as_date_czech` trims leading zeros.
#'
#' @inheritSection czech_date_internal Grammatical cases
#'
#' @inheritParams czech_date_internal
#'
#' @return Same as input, but with class `czech_date` and attribute
#'   `gramm_case`.
#' @family format related functions
#' @export
as_czech_date <- function(date, case = "genitive") {
  class(date) <- c("czech_date", class(date))
  attr(date, "gramm_case") <- match.arg(case, c("genitive", "nominative", "locative"))
  date
}


#' Print Czech Date
#'
#' S3 method for class `czech_date`.
#'
#' @inheritParams czech_date_internal
#' @keywords internal
#' @export
print.czech_date <- function(date, case = NULL, ...) {
  if (is.null(case)) case <- attr(date, "gramm_case")
  print(czech_date_internal(date, case))
  invisible(date)
}

#' as.character S3 method for class czech_date
#' @keywords internal
#' @export
as.character.czech_date <- function(date, case = NULL, ...) {
  if (is.null(case)) case <- attr(date, "gramm_case")
  czech_date_internal(date, case)
}

#' knit_print S3 method for class czech_date
#' @importFrom knitr knit_print asis_output
#' @keywords internal
#' @export
knit_print.czech_date <- function(date, case = NULL, ...) {
  if (is.null(case)) case <- attr(date, "gramm_case")
  asis_output(czech_date_internal(date, case))
}


#' Czech Date Internals
#'
#' Function used by S3 methods for class `czech_date`.
#'
#' @usage czech_date_internal(date, case = "genitive")
#'
#' @section Grammatical cases:
#' Three grammatical cases are supported:
#'  - *nominative* -- native form, i.e. "leden" in Czech
#'  - *locative* -- "in ...", i.e. "v lednu" in Czech
#'  - *genitive* -- "the 'nth' of ...", i.e. "5. ledna" in Czech
#'
#' Czech months listed by case are available in `.czech_months`.
#'
#' @param date *date or date-like object* to parse.
#' @param case *character*, either "nominative", "locative" or "genitive"
#'   (default) or any unambiguous abbreviation of these.
#'
#' @keywords internal
#' @export
czech_date_internal <- function(date, case) {
  dt <- as.POSIXlt(date) # hmmm POSIXlt is built on top of a list! exploit!
  day <- dt$mday
  month <- dt$mon + 1
  year <- dt$year + 1900

  case <- match.arg(case, c("genitive", "nominative", "locative"))

  paste0(day, ". ", .czech_months[[case]][month], " ", year)
}

#' List of Czech Months in Three Grammatical Cases
#'
#' As used by `czech_date_internal()`.
#'
#' @keywords internal
#' @export
.czech_months <- list(
  nominative = c(
    "leden", "únor", "březen", "duben", "květen", "červen", "červenec", "srpen", "září", "říjen", "listopad", "prosinec"
  ),
  locative = c(
    "lednu", "únoru", "březnu", "dubnu", "květnu", "červnu", "červenci", "srpnu", "září", "říjnu", "listopadu", "prosinci"
  ),
  genitive = c(
    "ledna", "února", "března", "dubna", "května", "června", "července", "srpna", "září", "října", "listopadu", "prosince"
  )
)


# interval_print <- function(x, y) {
#   days <- unique(day(c(x, y)))
#   months <- unique(month(c(x, y)))
#   years <- unique(year(c(x, y)))
#
#   if (length(days) != 1 & length(months) == 1 & length(years) == 1) {
#     paste0(days[1], ".–", days[2], ". ", month_czech(months[1], "gen"), " ", years[1])
#   } else if (length(days) != 1 & length(months) != 1 & length(years) == 1) {
#     paste0(days[1], ". ", month_czech(months[1], "gen"), " – ", days[2], ". ", month_czech(months[2], "gen"), " ", years[1])
#   } else if (length(days) != 1 & length(months) != 1 & length(years) != 1) {
#     paste0(days[1], ". ", month_czech(months[1], "gen"), " ", years[1], " – ", days[2], ". ", month_czech(months[2], "gen"), " ", years[2])
#   } else if (length(days) == 1 & length(months) != 1 & length(years) == 1) {
#     paste0(days[1], ". ", month_czech(months[1], "gen"), " – ", days[1], ". ", month_czech(months[2], "gen"), " ", years[1])
#   } else {
#     stop("Maturing lifecycle, case not yet defined...")
#   }
# }
