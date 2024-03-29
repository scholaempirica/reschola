% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/czech_date.R
\name{as_czech_date}
\alias{as_czech_date}
\title{Make Date of Class \code{czech_date}}
\usage{
as_czech_date(date, case = "genitive")
}
\arguments{
\item{date}{\emph{date or date-like object} to parse.}

\item{case}{\emph{character}, either "nominative", "locative" or "genitive"
(default) or any unambiguous abbreviation of these.}
}
\value{
Same as input, but with class \code{czech_date} and attribute
\code{gramm_case}.
}
\description{
Appends the \code{czech_date} class attribute to the input object. Date of class
\code{czech_date} is printed as a date in long format with correct Czech
grammatical case (see Details and Grammatical cases section below).
}
\details{
The grammatical case \emph{should} be specified as and argument to \code{print()}
method, but for convenience, you can predefine it in \code{as_czech_date} call
directly. It is then stored as an attribute, later grabbed by the \code{print}
method.

Note that as opposed to other date formating functions in \code{R},
\code{as_date_czech} trims leading zeros.
}
\section{Grammatical cases}{

Three grammatical cases are supported:
\itemize{
\item \emph{nominative} -- native form, i.e. "leden" in Czech
\item \emph{locative} -- "in ...", i.e. "v lednu" in Czech
\item \emph{genitive} -- "the 'nth' of ...", i.e. "5. ledna" in Czech
}

Czech months listed by case are available in \code{.czech_months}.
}

\examples{
Sys.time() \%>\% as_czech_date()

# in "nominative" grammatical case (note the abbreviation)
Sys.time() \%>\% as_czech_date("nom")
}
\concept{format related functions}
