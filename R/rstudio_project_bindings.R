#' schola_project
#'
#' Function to parse inputs from New project dialog and create new project
#'
#' @param path path
#' @param ... other params from new project dialog, created in DCF file
#' @keywords internal
#' @importFrom fs file_copy file_create dir_create dir_delete dir_copy
#' @importFrom usethis create_project proj_set proj_sitrep use_git use_github ui_info ui_stop ui_oops use_git_ignore ui_todo ui_code ui_path
#' @importFrom stringr str_glue
#' @importFrom googledrive as_dribble is_folder
#' @importFrom stringr str_remove str_trim
#'
#' @return TRUE
schola_project <- function(path, ...) {
  dots <- list(...)
  if (is.null(dots$title)) dots$title <- path

  orig_dir <- proj_sitrep()[["active_rstudio_proj"]]

  # create directory and project
  create_project(path, open = FALSE)
  proj_set(path)
  setwd(path)


  # text that will go into shared.R

  shared_code <- str_glue("
  # This file was generated by project setup to hold shared variables for project {dots$title}.
  # It is loaded by default by each RMarkdown file created using reschola's templates.
  # You should add all variables needed in multiple scripts here.\n
  # Do not add passwords, API keys and other information that should not be made public.\n
  # Store those in .Renviron. usethis::edit_r_environ() opens it for you for editing.
  project_title <- \"{dots$title}\"")

  writeLines(shared_code, con = "shared.R")

  # text that will go into build_all.R

  build_code <- c(
    str_glue(
      "# This file was generated by project setup for project {dots$title}."
    ),
    "# As you work on the project, you should add commands to this file so that",
    "# it contains the commands needed to rebuild the whole project from scratch.",
    "# Typically, those will be source() or rmarkdown::render() calls.",
    "# For starter, following lines will run through all .R scripts in data dir:",
    "",
    "library(reschola)",
    "library(tidyverse)",
    "library(here)",
    "library(fs)",
    "",
    "data_scripts <- list.files(here(\"data\"), pattern = \"^\\\\d+.*\\\\.[r|R]$\", full.names = TRUE)",
    "",
    "for (script in data_scripts) {",
    "  message(\"Processing \", path_file(script))",
    "  source(script, local = TRUE, encoding = \"UTF-8\")",
    "}",
    "",
    "message(\"Done! Check the warnings if any!\")",
    sep = "\n\n"
  )

  writeLines(build_code, con = "build_all.R")


  # README ------------------------------------------------------------------
  # nolint start: object_usage_linter
  title_readme <- ifelse(nzchar(dots$title), dots$title, path)
  # nolint end

  readme_text <- c(
    str_glue("# {title_readme}\n\n\n"),
    "<!-- badges: start -->",
    "<!-- badges: end -->\n",
    "This is the README file for your project. Edit it as you like.\n",
    "It shows up when someone looks at the Github repository.\n",
    "It should inform others what the project is about and give basic",
    "information about what is in the repository and how to use it.\n\n",
    "If you would like to run R code in your README, run `usethis::use_readme_rmd()`",
    "\n\n",
    "This project was created using the `reschola` project template",
    "and should follow the `reschola` workflow.\n",
    "See <scholaemprica.github.io/reschola> for details.\n\n\n",
    "Note that the `data-raw` and `data-processed` directories are intentionally configured",
    "to disallow adding files to git, and hence empty on Github.",
    "The raw data is to be inserted manually or downloaded from Google Drive",
    "and the processed data is created by the scripts in the project.\n",
    "See the project documentation to see exactly how to recreate the data files.",
    "Only change the .gitignore files in those directories if you are sure it is a good idea."
  )

  writeLines(readme_text, con = "README.md")


  # copy getting-started if option was checked
  if (dots$getting_started) {
    gs_rmd <- reschola_file(
      "rstudio", "templates", "project",
      "proj_fls", "getting-started.Rmd"
    )
    file_copy(gs_rmd, "getting-started.Rmd")
  }

  # copy logos if option was checked
  if (dots[["copy_logos"]]) {
    logos <- reschola_file(
      "rstudio", "templates", "project",
      "proj_fls", "logos"
    )
    dir_copy(logos, new_path = "logos")
  }

  # add sample report
  draft_pdf(name = "01_schola-report.Rmd", open = FALSE)


  # add data dir - note that empty subdirs are ignored, so we have to create them here (.gitkeep is not official)
  data <- reschola_file(
    "rstudio", "templates", "project", "proj_fls", "data"
  )
  dir_copy(data, new_path = "data")

  # create empty dirs for reports and data and add gitignore to them
  lapply(
    c("reports", paste("data", c("input", "intermediate", "processed"), sep = "/")),
    function(dir) {
      dir_create(dir)
      use_git_ignore(c("*", "!.gitignore"), dir) # have git ignore everything in that dir, except gitignore itself
    }
  )

  # delete R directory which was created automatically
  dir_delete("R")

  writeLines(readme_text, con = "README.md")


  # GDrive preps before commit ----------------------------------------------

  # write GDrive URL to .Rprofile
  if (!is.null(dots$drive_folder)) {
    # strip query that messes up {googledrive}
    dots$drive_folder <- str_trim(str_remove(dots$drive_folder, "(?=\\?).*"))

    # set URL into .Rprofile
    writeLines(
      str_glue(
        "# project's Google Drive URL\n.gd_proj_url <- \"{dots$drive_folder}\"\n\n",
        "# source user-scoped .Rprofile, if exists\nif (file.exists(path.expand(\"~/.Rprofile\"))) source(path.expand(\"~/.Rprofile\"))"
      ),
      con = ".Rprofile"
    )
  }

  # git ---------------------------------------------------------------------

  switch(dots[["vcs"]],
    none = ui_info("Not setting up any version control."),
    "local git" = tryCatch(use_git(message = "Repo setup"),
      error = function(cnd) {
        ui_oops("Local git initialization failed. Do you have git installed?")
      }
    ),
    "Schola's private GitHub repo" = {
      tryCatch(use_git(message = "Repo setup"),
        error = function(cnd) {
          ui_oops("Local git initialization failed. Do you have git installed?")
        }
      )
      tryCatch(use_github(organisation = "scholaempirica", private = TRUE),
        error = function(cnd) {
          ui_oops("Linking GitHub with your project failed. You may have to authenticate yourself. See {ui_code('?gh::gh_token')}.")
        }
      )
    }
  )


  # Gdrive download now -----------------------------------------------------

  if (!is.null(dots$drive_folder) && dots$drive_download) {
    gdrive_dribble <- tryCatch(as_dribble(dots$drive_folder),
      error = function(cnd) {
        ui_oops("You need to authenticate your Google account with R first.")
        ui_todo(c(
          "Run {ui_code('googledrive::drive_auth()')} after the project is created",
          "then download the files from Drive using {ui_code('gd_download_folder(gd_url)')}."
        ))
      }
    )

    if (!is_folder(gdrive_dribble)) {
      ui_stop("It seems the Google Drive folder URL you have given does not point to a folder.")
    }

    ui_info("Downloading contents of GDrive to {ui_path('data/input')}...")
    gd_download_folder(dots$drive_folder, overwrite = FALSE, files_from_subfolders = TRUE)
  }

  if (dots$drive_download && is.null(dots$drive_folder)) {
    ui_oops("You asked for the GDrive files to be downloaded, but provided no URL.\nNothing was downloaded.")
  }


  suppressMessages(proj_set(orig_dir))
  try(setwd(orig_dir), silent = TRUE)
  return(TRUE)
}
