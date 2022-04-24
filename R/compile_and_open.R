#' Safely Compile RMarkdown Document(s)
#'
#' Saves everything opened in a current project, renders (compiles) chosen
#' `.Rmd` document(s), and opens the resulting file if everything went OK.
#'
#' @param input path to source `.Rmd` file
#' @param output_dir output directory, default to "reports-output"
#' @param open_on_success if compilation went successul, open the result,
#'   default to TRUE
#' @inheritDotParams rmarkdown::render -input -output_dir
#'
#' @importFrom rstudioapi isAvailable documentSaveAll executeCommand
#' @importFrom rmarkdown render
#' @importFrom usethis ui_code ui_info
#' @return No return value. Called for side effects.
#'
#' @examples
#' \dontrun{
#' # for which REDIZOs should the reports be compiled?
#' red_izos <- c("600000001", "600000002", "600000003")
#'
#' purrr::map(
#'   red_izos,
#'   ~ compile_and_open("05_ucitele-reditele_ms.Rmd",
#'     open_on_success = FALSE,
#'     output_dir = here("reports-output", "ucitele-reditele-ms"),
#'     output_file = paste0("02_ucitele-reditele-ms_", .x, ".docx"),
#'     params = list(redizo = .x)
#'   )
#' )
#' }
#'
#' @export
compile_and_open <-
  function(input, output_dir = "reports-output", open_on_success = TRUE, ...) {
    result <- tryCatch(
      {
        if (isAvailable()) {
          documentSaveAll()
          executeCommand("activateConsole")
        }
        render(input, output_dir = output_dir, ...)
      },
      error = function(e) {
        message(
          "ERROR: Report compilation failed with message:\n",
          "----------------------------------------------"
        )
        message(e)
        return("fail")
      }
    )

    if (result != "fail" & open_on_success == TRUE) {
      system2("open", result)
    } else if (result == "fail" & open_on_success == TRUE) {
      message("Compilation failed, nothing to open!")
    } else {
      ui_info(c(
        "Pass {ui_code('open_on_success = TRUE')} if you want to open the output file",
        "automatically (applies to successful compilation only)."
      ))
    }
  }
