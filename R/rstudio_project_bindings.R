
#' schola_project
#'
#' Function to parse inputs from New project dialog and create new project
#'
#' @param path path
#' @param ... other params from new project dialog, created in DCF file
#' @keywords internal
#' @return TRUE
schola_project <- function(path, ...) {
  # print(usethis::proj_sitrep())
  dots <- list(...)

  orig_dir <- usethis::proj_sitrep()[["active_rstudio_proj"]]

  # create directory and project

  usethis::create_project(path, open = FALSE)
  usethis::proj_set(path)
  setwd(path)
  # print("dir created")
  # print(usethis::proj_sitrep())

  # handle git(hub) setup

  # print("start switch")
  switch(dots[["vcs"]],
    none = usethis::ui_info("Not setting up any git version control."),
    "local git" = usethis::use_git(),
    "Github: private owned by me" = {
      # print("use_git")
      usethis::use_git()
      # print("use_github")
      usethis::use_github(private = T)
    },
    "Github: public owned by me" = {
      usethis::use_git()
      usethis::use_github()
    },
    "Github: public owned by scholaempirica" = {
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

  # print(usethis::proj_sitrep())
  draft_word(name = "First-Schola-styled-Word.Rmd", open = F)
  draft_redoc(name = "First-Schola-styled-redoc.Rmd", open = F)

  # usethis::ui_todo("You should run {usethis::ui_code('usethis::proj_set(getwd())')} in your original session to get your working directory sorted.")
  suppressMessages(usethis::proj_set(orig_dir))
  try(setwd(orig_dir), silent = T)
  return(TRUE)
}
