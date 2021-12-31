#'
#' #' Authenticate to Google Workspace / Gmail
#' #'
#' #' Obtains credentials and stores them in dedicated environment for further use by
#' #' `compose()` and `send()` functions.
#' #'
#' #' The credentials used for user authentication are obtained through interactive
#' #' prompts, mainly for security reasons. The function tries to obtain the
#' #' credentials from the system environment variable table first. If none found,
#' #' the user is asked for them and is provided with a guidance for permanent
#' #' credential storage.
#' #'
#' #' @param domain *character*, email domain. Default to \@scholaempirica.org
#' #'
#' #' @return Called for side effects.
#' #'
#' #' @examples
#' #' \dontrun{
#' #' }
#' #'
#' #' @family mailing functions
#' #'
#' #' @importFrom usethis edit_r_environ ui_stop ui_field ui_code ui_done
#' #'   ui_code_block ui_todo
#' #' @importFrom httr POST content_type_json content
#' #' @importFrom stringr str_detect
#' #' @importFrom jsonlite toJSON fromJSON
#' #' @importFrom rstudioapi showPrompt askForPassword
#' #'
#' #' @export
#' gw_auth <- function(domain = "@scholaempirica.org") {
#'   if (!nzchar(Sys.getenv("GW_USER")) || !nzchar(Sys.getenv("GW_PASS"))) {
#'     while (!exists("user") || is.null(user)) {
#'       user <- showPrompt(
#'         "Google Workspace / Gmail username",
#'         "Cannot retrieve any username, please enter it here."
#'       )
#'
#'       if (stringr::str_detect(user, "@")) {
#'         user <- NULL
#'         ui_oops(c(
#'           "This username looks like a complete email address, enter only the part before '@'.",
#'           "The domain is appended automatically from function call argument {ui_field('domain')}."
#'         ))
#'       }
#'     }
#'
#'
#'     user <- paste0(user, domain)
#'
#'     pass <- askForPassword("Google Workspace / Gmail username password")
#'
#'     Sys.setenv(GW_USER = user, GW_PASS = pass)
#'
#'     ui_info("The credentials are saved and available only for this session. To store them safely and permanently...")
#'     ui_todo("...append following two lines to your {ui_field('.Renviron')} file, a value per line. The file must end with an empty line.")
#'     ui_code_block(paste0(
#'       "GW_USER=", user, "\n",
#'       "GW_PASS=", pass
#'     ))
#'
#'     edit_r_environ()
#'   }
#'
#'   if (!nzchar(Sys.getenv("GW_NAME"))) {
#'     Sys.setenv(GW_NAME = domain)
#'   }
#'
#'   assign("gw_cred", res, envir = gw_cache)
#'
#'   if (exists("gw_cred", envir = gw_cache)) {
#'     ui_done("Credentials successfully stored in a cache.")
#'   }
#' }
#'
#' # env to store creds in, must be defined outside any function
#' gw_cache <- new.env(parent = emptyenv())
#'
#'
#' #
#' # # -----------------------------------------------------------------------
#' # # Nice examples at https://github.com/rpremraj/mailR
#' #
#' # library(tidyverse)
#' # library(mailR)
#' # library(here)
#' # source("shared.R") # import GSuite auth function
#' #
#' #
#' # # prepare contacts for the first wave
#' # # only coord_teachers + headmasters
#' # contact_list <- read_rds(here("data-input/contact_list.rds"))
#' #
#' # # add BCC for MS, make final list
#' # emails <- contact_list %>%
#' #   # filter(contact_type != "teacher") %>%
#' #   mutate(bcc = if_else(school_type == "MS",
#' #                        list("michalova@scholaempirica.org"),
#' #                        list("sloufova@scholaempirica.org")
#' #   ))
#' #
#' # # resend_ZS_contacts <- read_rds(here("data-input/resend_ZS_contacts.rds"))
#' #
#' # # resend instructions (contacts from)
#' # # emails <- emails %>% filter(email %in% resend_ZS_contacts)
#' #
#' # # emails <- emails %>% filter(school == "MŠ Svémyslice")
#' # emails <- emails %>% filter(school == "MŠ Sluníčko pod střechou" & is_interv == 0)
#' #
#' # # prepare table of recipients, subject, body, file paths, everything
#' # emails <- emails %>% mutate(
#' #   subject = "Instrukce k prvnímu měření – Rozvoj socio-emočních dovedností v MŠ a ZŠ",
#' #   group = if_else(is_interv, "intervencni", "kontrolni"),
#' #   body = if_else(school_type == "MS",
#' #                  here("email", school_type, "ms_email_body.txt"),
#' #                  here("email", school_type, "zs_email_body.txt")
#' #   ),
#' #   appdx = pmap(list(school_type, group, name), ~ c(
#' #     here("email", ..1, ..2, "IvP_instrukce-k-dotaznikum_pro-ucitele.pdf"),
#' #     here("email", ..1, ..2, "IvP_informovany-souhlas-pro-rodice.pdf"),
#' #     if (..1 == "MS") here("email", "MS", "Dotaznik_SDQ_pro_ucitele.pdf"),
#' #     here("id_codes", paste0(..3, ".xlsx"))
#' #   ))
#' # )
#' #
#' # # sent after contact list repair
#' # # emails <- emails %>% filter(email %in% c("ms.zilina@seznam.cz", "info@mshavaj.cz", "ludmila.zelinkova@seznam.cz"))
#' #
#' # # do files really exist?
#' # unlist(emails$appdx)[emails$appdx %>% unlist %>% map_lgl(~!file.exists(.x))]
#' #
#' #
#' # # prepare email "send job" (object-orienter programming...)
#' # jobs <- pmap(
#' #   list(
#' #     emails$email, # ..1
#' #     emails$cc, # ..2
#' #     emails$bcc, # ..3
#' #     emails$subject, # ..4
#' #     emails$body, # ..5
#' #     emails$appdx # ..6
#' #   ),
#' #   ~ send.mail(
#' #     from = paste0("Jan Netík", " <", gmail_cred("user"), ">"),
#' #     to = ..1,
#' #     cc = if (is.na(..2)) {NULL} else {..2},
#' #     bcc = ..3,
#' #     subject = ..4,
#' #     body = ..5,
#' #     attach.files = ..6,
#' #     html = TRUE, # ensure that images paths are relative to the project root!!!
#' #     inline = TRUE, # for images
#' #     smtp = list(host.name = "smtp.gmail.com", port = 587,
#' #                 user.name = gmail_cred("user"), passwd = gmail_cred("pass"), ssl = TRUE),
#' #     authenticate = TRUE,
#' #     encoding = "utf-8",
#' #     send = FALSE,
#' #     debug = TRUE
#' #   )
#' # )
#' #
#' # # BEWARE! this line executes the whole job (after prompt...)
#' # if (usethis::ui_yeah("Execute the job?")) {
#' #   walk(jobs, ~ try(.x$send()))
#' # }
#' #
#' # # if you wanna send just one "iteration", use indexing, like:
#' # # jobs[[1]]$send()
