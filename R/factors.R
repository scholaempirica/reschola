
#' NAnify factor level
#'
#' The inverse of `fct_explicit_na()`. Turns the `level` into proper `NA`.
#' **Retains the level.**
#'
#' @param f *factor* to work on
#' @param level *character*,
#'
#' @return *factor* with NA-substituted level.
#' @export
#'
#' @importFrom rlang abort
#'
#' @examples
#' f <- factor(c("a", "b", "c", "nanify"))
#' fct_nanify(f, "nanify")
fct_nanify <- function(f, level) {
  # ensure f is a factor
  if (!inherits(f, "factor")) {
    f <- as.factor(f)
  }

  lvls <- levels(f)

  if(!level %in% lvls) {
    abort("No such level in the factor.")
  }
  if (lvls[length(lvls)] != level) {
    warning(c(
      "Nanifying a level that is not at last position...\n",
      "Coercion to another class will likely give an unintended result."
    ), call. = FALSE)
  }

  f[f == level] <- NA

  f
}
