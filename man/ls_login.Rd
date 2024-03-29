% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/limesurvey.R
\name{ls_login}
\alias{ls_login}
\title{Login to LimeSurvey API}
\usage{
ls_login(
  api_url =
    "https://dotazniky.scholaempirica.org/limesurvey/index.php/admin/remotecontrol"
)
}
\arguments{
\item{api_url}{\emph{character}, URL of the API endpoint, default to SCHOLA
EMPIRICA's LimeSurvey API.}
}
\value{
No "explicit" return value, but assigns the session key to a
dedicated environment.
}
\description{
Obtains XML-RPC/JSON-RPC session key and stores it in dedicated environment
for further use by fellow \code{ls_} functions.
}
\details{
By default,
\url{https://dotazniky.scholaempirica.org/}
is used as the LimeSurvey server prividing the API. The credentials used for
user authentication are obtained through interactive prompts, mainly for
security reasons. The function tries to obtain the credentials from the
system environment variable table first. If none found, the user is asked for
them and is provided with guidance for permanent credential storage.
}
\examples{
\dontrun{
ls_login()
}

}
\seealso{
Other LimeSurvey functions: 
\code{\link{ls_add_participants}()},
\code{\link{ls_call}()},
\code{\link{ls_export}()},
\code{\link{ls_get_attrs}()},
\code{\link{ls_invite}()},
\code{\link{ls_participants}()},
\code{\link{ls_responses}()},
\code{\link{ls_set_participant_properties}()},
\code{\link{ls_surveys}()}
}
\concept{LimeSurvey functions}
