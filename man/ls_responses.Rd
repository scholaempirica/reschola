% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/limesurvey.R
\name{ls_responses}
\alias{ls_responses}
\title{Export Responses}
\usage{
ls_responses(survey_id, lang = "cs", part = "all", ...)
}
\arguments{
\item{survey_id}{\emph{integer}, ID of the survey (as found with \code{ls_surveys},
e.g.).}

\item{lang}{\emph{character}, ISO 639 language code, default to \code{cs}.}

\item{part}{\emph{character}, completion status, either \code{complete}, \code{incomplete}
or \code{all} (the default).}

\item{...}{\emph{other named arguments} used by "export_responses" method. Use at
your own risk.}
}
\value{
A tibble, or raw object if server response cannot be reasonably
coerced to a tibble.
}
\description{
Fetches responses and applies so-called "R-syntax" transformation script from
LimeSurvey pertaining factor levels and items attributes (those are readily
available in RStudio dataframe preview and can be extracted using
\code{attributes()}).
}
\examples{
\dontrun{
ls_responses(123456)
}

}
\seealso{
Other LimeSurvey functions: 
\code{\link{ls_add_participants}()},
\code{\link{ls_call}()},
\code{\link{ls_export}()},
\code{\link{ls_get_attrs}()},
\code{\link{ls_invite}()},
\code{\link{ls_login}()},
\code{\link{ls_participants}()},
\code{\link{ls_surveys}()}
}
\concept{LimeSurvey functions}
