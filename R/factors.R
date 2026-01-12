#' NAnify factor level
#'
#' The inverse of `fct_explicit_na()`. Turns the `level` into proper `NA`.
#' **Retains the level.**
#'
#' @param f *factor* to work on
#' @param level *character*, regular expression matching the desired level
#' @param negate *logical*, whether to return non-matching elements. Defaults to
#'   `FALSE`.
#' @param ignore_case *logical*, ignore case when matching? Defaults to `TRUE`.
#'
#' @return *factor* with NA-substituted level.
#' @export
#'
#' @importFrom rlang abort inform warn
#' @importFrom stringr regex str_detect
#' @importFrom usethis ui_info
#'
#' @examples
#' f <- factor(c("a", "b", "c", "nanify"))
#' fct_nanify(f, "nanify")
#'
fct_nanify <- function(f, level, negate = FALSE, ignore_case = TRUE) {
  # ensure f is a factor to ensure correct subset method is dispatched
  if (!inherits(f, "factor")) {
    f <- as.factor(f)
  }

  match <- str_detect(
    f,
    regex(level, ignore_case = ignore_case),
    negate = negate
  )

  if (all(!match, na.rm = TRUE)) {
    warn("No such level in the factor. Nothing will happen.")
    return(f)
  }

  f[match] <- NA

  inform(
    body = c(
      "i" = paste(
        "Before coercing to integer, make sure the level",
        "you have just NAnified is the last one, so no number is skipped!"
      )
    ),
    .frequency = "once",
    .frequency_id = "fct_nanify_coercion_warning"
  )

  f
}
