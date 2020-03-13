
#' FUNCTION_TITLE
#'
#' FUNCTION_DESCRIPTION
#'
#' @param  DESCRIPTION.
#'
#' @return RETURN_DESCRIPTION
#' @examples
#' # ADD_EXAMPLES_HERE
schola_project <- function(path, ...) {
  dots <- list(...)

  # create directort

  dir.create(path, recursive = TRUE, showWarnings = FALSE)

  # create project

  setwd(path)
  usethis::create_project(".", open = FALSE)

  # handle git(hub) setup

  switch(dots[["vcs"]],
    none = usethis::ui_info("Not setting up any git version control."),
    "local git" = usethis::use_git(),
    "private Github (mine)" = {
      usethis::use_git()
      usethis::use_github(private = T)
    },
    "public Github (mine)" = {
      usethis::use_git()
      usethis::use_github()
    },
    "public Github (scholaempirica)" = {
      usethis::use_git()
      usethis::use_github(organisation = "scholaempirica")
    },
  )

  if (dots[["copy_logos"]]) {
    logos <- reschola_file(
      "rstudio", "templates", "project",
      "schola_project_resources", "logos"
    )

    fs::dir_copy(logos, new_path = "logos")
  }


  draft_word(name = "First-Schola-styled-Word.Rmd", open = F)
  draft_redoc(name = "First-Schola-styled-redoc.Rmd", open = F)

  return(TRUE)
}
