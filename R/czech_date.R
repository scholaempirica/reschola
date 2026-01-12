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
#' @inheritSection czech_date_main Grammatical cases
#'
#' @inheritParams czech_date_main
#'
#' @examples
#' Sys.time() |> as_czech_date()
#'
#' # in "nominative" grammatical case (note the abbreviation)
#' Sys.time() |> as_czech_date("nom")
#' @return Same as input, but with class `czech_date` and attribute
#'   `gramm_case`.
#' @family format related functions
#' @export
as_czech_date <- function(date, case = "genitive") {
  class(date) <- c("czech_date", class(date))
  attr(date, "gramm_case") <- match.arg(
    case,
    c("genitive", "nominative", "locative")
  )
  date
}


#' Print Czech Date
#'
#' S3 method for class `czech_date`.
#'
#' @inheritParams czech_date_main
#' @keywords internal
#' @export
print.czech_date <- function(x, ...) {
  case <- list(...)[["case"]]
  if (is.null(case)) {
    case <- attr(x, "gramm_case")
  }
  print(czech_date_main(x, case))
  invisible(x)
}

#' as.character S3 method for class czech_date
#' @keywords internal
#' @export
as.character.czech_date <- function(x, ...) {
  case <- list(...)[["case"]]
  if (is.null(case)) {
    case <- attr(x, "gramm_case")
  }
  czech_date_main(x, case)
}

#' knit_print S3 method for class czech_date
#' @importFrom knitr knit_print asis_output
#' @keywords internal
#' @export
knit_print.czech_date <- function(x, ...) {
  # nolint: object_name_linter
  case <- list(...)[["case"]]
  if (is.null(case)) {
    case <- attr(x, "gramm_case")
  }
  asis_output(czech_date_main(x, case))
}


#' Czech Date Internals
#'
#' Function used by S3 methods for class `czech_date`.
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
czech_date_main <- function(date, case) {
  dt <- as.POSIXlt(date) # hmmm POSIXlt is built on top of a list! exploit!
  day <- dt$mday
  month <- dt$mon + 1
  year <- dt$year + 1900

  case <- match.arg(case, c("genitive", "nominative", "locative"))

  paste0(day, ". ", .czech_months[[case]][month], " ", year)
}

#' List of Czech Months in Three Grammatical Cases
#'
#' As used by `czech_date_main()`.
#'
#' @keywords internal
#' @export
.czech_months <- list(
  nominative = c(
    "leden",
    "\u00fanor",
    "b\u0159ezen",
    "duben",
    "kv\u011bten",
    "\u010derven",
    "\u010dervenec",
    "srpen",
    "z\u00e1\u0159\u00ed",
    "\u0159\u00edjen",
    "listopad",
    "prosinec"
  ),
  locative = c(
    "lednu",
    "\u00fanoru",
    "b\u0159eznu",
    "dubnu",
    "kv\u011btnu",
    "\u010dervnu",
    "\u010dervenci",
    "srpnu",
    "z\u00e1\u0159\u00ed",
    "\u0159\u00edjnu",
    "listopadu",
    "prosinci"
  ),
  genitive = c(
    "ledna",
    "\u00fanora",
    "b\u0159ezna",
    "dubna",
    "kv\u011btna",
    "\u010dervna",
    "\u010dervence",
    "srpna",
    "z\u00e1\u0159\u00ed",
    "\u0159\u00edjna",
    "listopadu",
    "prosince"
  )
)


#' Czech Date Interval
#'
#' Returns the most space-efficient and at the same time grammatically correct
#' interval of two Czech dates. When both dates are the same, only one is
#' outputted. The function ensures that the interval is not negative (i.e.,
#' `start` <= `end`), otherwise, it is reversed.
#'
#' @param start *Date of date-like object*, start date or left boundary of an
#'   interval.
#' @param end *Date of date-like object*, end date or right boundary of an
#'   interval.
#'
#' @examples
#' czech_date_interval("2020-01-24", "2020-01-03") # note the argument order
#' @return Character
#'
#' @importFrom rlang abort
#' @export
czech_date_interval <- function(start, end) {
  if (length(start) != 1 || length(end) != 1) {
    abort("You cannot provide more than one start or end date.")
  }

  dt <- as.POSIXlt(c(start, end))

  if (start > end) {
    dt <- rev(dt)
  }

  day <- dt$mday
  month <- dt$mon + 1
  year <- dt$year + 1900

  czech_date <- as_czech_date(dt)
  czech_months <- .czech_months[["genitive"]][month]

  res <- if (year[1] == year[2]) {
    if (month[1] == month[2]) {
      if (day[1] == day[2]) {
        czech_date[1]
      } else {
        paste0(
          day[1],
          ".\u2013",
          day[2],
          ". ",
          czech_months[1],
          " ",
          year[1]
        )
      }
    } else {
      paste0(
        day[1],
        ". ",
        czech_months[1],
        " \u2013\ ",
        day[2],
        ". ",
        czech_months[2],
        " ",
        year[1]
      )
    }
  } else {
    paste0(czech_date[1], " \u2013 ", czech_date[2])
  }

  class(res) <- "czech_date_interval"
  res
}


#' knit_print S3 method for class czech_date_interval
#' @importFrom knitr knit_print asis_output is_latex_output
#' @keywords internal
#' @export
knit_print.czech_date_interval <- function(x, ...) {
  # nolint: object_name_linter
  if (is_latex_output()) {
    x <- gsub("\u2013", "\\\\nobreakdash\u2013", x)
  }
  asis_output(x)
}

#' print S3 method for class czech_date_interval
#' @keywords internal
#' @export
print.czech_date_interval <- function(x, ...) {
  print(as.character(x))
  invisible(x)
}
