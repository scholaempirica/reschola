#' List All Surveys at the Server
#'
#' Lists every single survey found at the server you are logged in. Useful to
#' gain information about surveys IDs etc.
#'
#' @return A tibble.
#' @family LimeSurvey functions
#'
#' @examples
#' \dontrun{
#' ls_surveys()
#' }
#'
#' @importFrom dplyr rename
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#'
#' @export
ls_surveys <- function() {
  ls_call("list_surveys") %>% rename(survey_id = .data$sid, title = .data$surveyls_title)
}


#' Export Responses with Participants Attached
#'
#' @inheritParams ls_responses
#' @inheritParams ls_participants
#' @param join_by *character*, the joining variable present in both responses
#'   and participants tibbles. Default to `token`. Pass `NULL` to join by common
#'   variables.
#' @inheritDotParams dplyr::left_join -x -y -by
#'
#' @return A tibble.
#' @examples
#' \dontrun{
#' ls_export(123456)
#' }
#'
#' @importFrom dplyr left_join
#' @importFrom usethis ui_stop ui_code
#' @importFrom tidyselect eval_rename
#' @importFrom rlang %@% %@%<-
#'
#' @family LimeSurvey functions
#' @export
ls_export <- function(survey_id, attributes = TRUE, n_participants = 999,
                      lang = "cs", part = "all", only_unused_tokens = FALSE,
                      join_by = "token", ...) {
  participants <- ls_participants(survey_id,
    n_participants = n_participants,
    only_unused_tokens = only_unused_tokens, attributes = attributes
  )

  responses <- ls_responses(survey_id, lang = lang, part = part)

  res <- left_join(participants, responses, by = join_by, ...)

  # put back variable labels stripped during the merge, using safe tidyselect approach
  resp_names <- responses %>% names()
  resp_vals <- responses %@% "variable.labels"
  names(resp_names) <- resp_vals
  loc <- tryCatch(eval_rename(resp_names, res), error = function(e) {
    ui_stop(c(
      "Column names of joined participant and response tables are likely duplicated.",
      ifelse(attributes,
        "Passing {ui_code('attributes = FALSE')} to function call may help.",
        "Please treat participant and response data separately."
      )
    ))
  })
  attrs <- names(res)
  attrs[loc] <- names(loc)
  res %@% "variable.labels" <- attrs

  res
}


#' Login to LimeSurvey API
#'
#' Obtains XML-RPC/JSON-RPC session key and stores it in dedicated environment
#' for further use by fellow `ls_` functions.
#'
#' By default,
#' [http://dotazniky.scholaempirica.org/](http://dotazniky.scholaempirica.org/)
#' is used as the LimeSurvey server prividing the API. The credentials used for
#' user authentication are obtained through interactive prompts, mainly for
#' security reasons. The function tries to obtain the credentials from the
#' system environment variable table first. If none found, the user is asked for
#' them and is provided with guidance for permanent credential storage.
#'
#' @param api_url *character*, URL of the API endpoint, default to SCHOLA
#'   EMPIRICA's LimeSurvey API.
#'
#' @return No "explicit" return value, but assigns the session key to a
#'   dedicated environment.
#'
#' @examples
#' \dontrun{
#' ls_login()
#' }
#'
#' @family LimeSurvey functions
#'
#' @importFrom usethis edit_r_environ ui_stop ui_field ui_code ui_done ui_code_block ui_todo
#' @importFrom httr POST content_type_json content
#' @importFrom jsonlite toJSON fromJSON
#' @importFrom httr RETRY content_type_json status_code http_status
#' @importFrom rstudioapi showPrompt askForPassword
#'
#' @export
ls_login <- function(api_url = "http://dotazniky.scholaempirica.org/limesurvey/index.php/admin/remotecontrol") {
  if (!nzchar(Sys.getenv("LS_USER")) || !nzchar(Sys.getenv("LS_PASS"))) {
    user <- showPrompt(
      "LimeSurvey username",
      "It seems you have no LimeSurvey username stored, please enter it here."
    )

    pass <- askForPassword("LimeSurvey password")

    Sys.setenv(LS_USER = user, LS_PASS = pass)

    ui_info("The credentials are saved and available only for this session. To store them safely and permanently...")
    ui_todo("...append following two lines to your {ui_field('.Renviron')} file, a value per line. The file must end with an empty line.")
    ui_code_block(paste0(
      "LS_USER=", user, "\n",
      "LS_PASS=", pass
    ))

    edit_r_environ()
  }

  if (!nzchar(Sys.getenv("LS_URL"))) {
    Sys.setenv(LS_URL = api_url)
  }

  body <- list(
    method = "get_session_key", id = " ",
    params = list(
      admin = Sys.getenv("LS_USER"),
      password = Sys.getenv("LS_PASS")
    )
  )

  r <- RETRY("POST", api_url, content_type_json(), body = toJSON(body, auto_unbox = TRUE))
  if (status_code(r) != 200) {
    stop(http_status(r)$message)
  }

  content <- content(r, encoding = "utf-8")
  if (!is.character(content) && is.null(content$result)) {
    ui_stop("Server is responding but not in a proper way. Please check the API URL and server configuration.")
  }

  res <- fromJSON(content)$result
  if (class(res) == "list" && !is.null(res$status)) {
    ui_stop(res$status)
  }

  assign("sess_key", res, envir = ls_sess_cache)
  assign("sess_key_expiration", Sys.time() + 7200, envir = ls_sess_cache) # default session expiration is 2 hrs = 7200 s


  if (exists("sess_key", envir = ls_sess_cache)) {
    ui_done("Session key sucessfuly obtained and stored in a cache.")
  }
}


# env to store ls key in, must be defined outside any function
ls_sess_cache <- new.env(parent = emptyenv())


#' Call LimeSurvey API Directly
#'
#' General function used internally by every other `ls_` fellow. Useful when you
#' want something special that is not (yet) implemented in `reschola`.
#'
#' [The list of available LimeSurvey API
#' calls](https://api.limesurvey.org/classes/remotecontrol_handle.html) briefly
#' documents the functionality provided. You must strictly adhere to the
#' arguments positions, as they are passed as an array.
#'
#' @param method *character*, a method supported by LimeSurvey API.
#' @param params *list*, arguments of the method. Need to be in order stated in
#'   documentation.
#'
#' @return A tibble, or raw object if server response cannot be reasonably
#'   coerced to a tibble.
#'
#' @examples
#' \dontrun{
#' ls_call("get_survey_properties", params = list(iSurveyID = 123456))
#' }
#'
#' @importFrom usethis ui_stop ui_field ui_code ui_info ui_value ui_oops
#' @importFrom jsonlite toJSON fromJSON
#' @importFrom tibble as_tibble
#' @importFrom purrr pluck
#' @importFrom httr RETRY content_type_json status_code http_status
#'
#' @family LimeSurvey functions
#'
#' @export
ls_call <- function(method, params = list()) {
  if (!is.list(params)) {
    ui_stop("{ui_field('params')} must be a list.")
  }
  if (!exists("sess_key_expiration", envir = ls_sess_cache) || ls_sess_cache$sess_key_expiration < Sys.time()) {
    ui_oops(c(
      "Cannot find valid session key in the cache.",
      "Either the key wasn't entered at all or it may have expired."
    ))

    ui_info("Remedy by calling {ui_code('ls_login()')}.")
    ls_login()
  }

  params <- c(sSessionKey = ls_sess_cache$sess_key, params = params)
  body <- list(method = method, id = " ", params = params)
  r <- RETRY("POST", Sys.getenv("LS_URL"), content_type_json(),
    body = toJSON(body, auto_unbox = TRUE, null = "null")
  )

  parsed <- fromJSON(content(r,
    as = "text",
    encoding = "utf-8"
  ))

  res <- parsed$result

  status_msg <- pluck(res, "status")

  if (!is.null(status_msg)) {
    ui_stop("API returned message:\n{ui_value(as.character(status_msg))}.")
  }

  # try to make tibble from everything, return raw object when conversion fails
  if (!inherits(res, c("tbl_df", "character", "list"))) {
    tryCatch(
      as_tibble(res),
      error = function(e) {
        return(res)
      }
    )
  } else {
    res
  }
}


#' List Participants
#'
#' Fetches participant list of the solicited survey. The function tries to
#' retrieve as many attributes as possible and translate them to their
#' "semantic" version by default. You can also provide character vector of
#' requested attributes, but not in the "semantic" form (use, e.g.,
#' `attribute_1` or `usesleft`).
#'
#' @param survey_id *integer*, ID of the survey (as found, e.g., with
#'   `ls_surveys()`).
#' @param attributes *logical* try to recover all attributes (default to TRUE),
#'   or *character vector* specifying requested attributes.
#' @param n_participants *integer*, the number of participants to list, defualt
#'   to 999.
#' @param only_unused_tokens *logical*, should only the unused tokens be listed?
#'   Default to FALSE.
#' @param translate_attrs *logical*, should the custom attributes be
#'   "translated" to "semantic" version? Default to TRUE.
#'
#' @return A tibble, or raw object if server response cannot be reasonably
#'   coerced to a tibble.
#'
#' @examples
#' \dontrun{
#' ls_participants(123456, attributes = c("usesleft"))
#' }
#'
#' @importFrom tidyr unpack
#' @importFrom dplyr rename
#' @importFrom rlang !!! set_names
#' @importFrom purrr pluck map_chr
#' @importFrom usethis ui_stop ui_value
#'
#' @family LimeSurvey functions
#' @export
ls_participants <- function(survey_id, attributes = TRUE, n_participants = 999,
                            only_unused_tokens = FALSE, translate_attrs = TRUE) {
  attrs_call <- attributes
  if (is.logical(attributes)) {
    if (attributes) {
      attributes <- .ls_all_attributes
    }
  } else {
    illegal_attr <- !attributes %in% .ls_all_attributes
    if (any(illegal_attr)) {
      ui_stop(c(
        "Following attributes are not supported: {ui_value(attributes[illegal_attr])}.",
        "For custom attributes, use {ui_value('attribute_1 ... attribute_n')}.",
        "\"Semantic\" names are not supported at the input side."
      ))
    }
  }

  res <- ls_call("list_participants", params = list(
    iSurveyID = survey_id,
    iStart = 0,
    iLimit = n_participants,
    bUnused = only_unused_tokens,
    aAttributes = as.list(attributes)
  ))

  res <- unpack(res, "participant_info")

  if (translate_attrs && isTRUE(attrs_call)) {
    attrs <- ls_call("get_survey_properties", params = list(iSurveyID = survey_id)) %>%
      pluck("attributedescriptions")

    if (is.null(attrs)) {
      ui_info("No attributes we found.")
      return(res)
    } else {
      attrs <- attrs %>%
        fromJSON() %>%
        map_chr("description")

      attrs <- set_names(names(attrs), attrs) # swap names-values

      res %>% rename(!!!attrs)
    }
  } else {
    res
  }
}


# define possible LS attributes --- may need updates
.ls_all_attributes <- c(
  "id", "tid",
  "completed",
  "participant_id",
  "language string",
  "usesleft",
  "firstname",
  "lastname",
  "email",
  "blacklisted",
  "validfrom",
  "sent",
  "validuntil",
  "remindersent",
  "mpid",
  "emailstatus",
  "remindercount",
  paste0("attribute_", 1:100)
)



#' Export Responses
#'
#' Fetches responses and applies so-called "R-syntax" transformation script from
#' LimeSurvey pertaining factor levels and items attributes (those are readily
#' available in RStudio dataframe preview and can be extracted using
#' `attributes()`).
#'
#' @param survey_id *integer*, ID of the survey (as found with `ls_surveys`,
#'   e.g.).
#' @param lang *character*, ISO 639 language code, default to `cs`.
#' @param part *character*, completion status, either `complete`, `incomplete`
#'   or `all` (the default).
#' @param ... *other named arguments* used by "export_responses" method. Use at
#'   your own risk.
#'
#' @return  A tibble, or raw object if server response cannot be reasonably
#'   coerced to a tibble.
#' @examples
#' \dontrun{
#' ls_responses(123456)
#' }
#'
#' @importFrom jsonlite base64_dec
#' @importFrom utils read.csv2
#' @importFrom tibble as_tibble
#' @family LimeSurvey functions
#'
#' @export
ls_responses <- function(survey_id, lang = "cs", part = "all", ...) {
  part <- match.arg(part, c("complete", "incomplete", "all"))

  data <- ls_call("export_responses",
    params = list(
      iSurveyID = survey_id,
      sDocumentType = "rdata",
      sLanguageCode = lang,
      sCompletionStatus = part,
      ...
    )
  )

  data <- rawToChar(base64_dec(data))

  data <- read.csv2(textConnection(data),
    encoding = "UTF-8"
  )

  syntax <- ls_call("export_responses",
    params = list(
      iSurveyID = survey_id,
      sDocumentType = "rsyntax",
      sLanguageCode = lang,
      sCompletionStatus = part,
      ...
    )
  )

  syntax <- readLines(textConnection(rawToChar(base64_dec(syntax))), encoding = "UTF-8")[-1] # exclude first line (data already read)

  # suppres those "NAs introduced by coercion" warnings of no value but disturbing
  suppressWarnings(source(textConnection(syntax), local = TRUE))

  as_tibble(data, .name_repair = ~ make.unique(.x, "_"))

  # TODO: think how to handle attributes
}



# proposals

# ls_call("get_survey_properties", params = list(iSurveyID = 123456)) # set_ vesrsion avaiable, way to set attributes??

# mail_registered_participants

# add_participants
