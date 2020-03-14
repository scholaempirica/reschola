
#' A Schola Empirica ggplot2 theme
#'
#' FUNCTION_DESCRIPTION
#'
#' @param base_size DESCRIPTION.
#' @param gridlines DESCRIPTION.
#' @param family DESCRIPTION.
#' @param title_family DESCRIPTION.
#' @param side_margin DESCRIPTION.
#' @param plot.title.position DESCRIPTION.
#' @param axis.title DESCRIPTION.
#' @param ... DESCRIPTION.
#'
#' @return RETURN_DESCRIPTION
#' @family Making charts
#' @examples
#' # ADD_EXAMPLES_HERE
#' @export
theme_schola <- function(base_size = 11,
                         gridlines = c("y", "x", "both", "scatter"),
                         family = "sans", title_family,
                         side_margin = 6,
                         plot.title.position = "plot",
                         axis.title = ggplot2::element_blank(),
                         ...) {
  grd <- match.arg(gridlines)
  grid_col <- if(grd == "scatter") "white" else "grey90"
  bg_col <- if(grd == "scatter") "grey90" else "white"
  element_gridline <- ggplot2::element_line(colour = grid_col, size = 0.3)
  thm <- ggplot2::theme_minimal(base_size = base_size, base_family = family) +
    ggplot2::theme(plot.title.position = plot.title.position,
                   panel.grid.minor = ggplot2::element_blank(),
                   panel.grid.major.x = if(grd != "y")
                     element_gridline else ggplot2::element_blank(),
                   panel.grid.major.y = if(grd != "x")
                     element_gridline else ggplot2::element_blank(),
                   # axis.line = ggplot2::element_line(),
                   panel.background = ggplot2::element_rect(fill = bg_col,
                                                            colour = NA),
                   axis.title = axis.title,
                   plot.margin = ggplot2::unit(c(10, side_margin, 10, side_margin),
                                               units = "pt"))

  thm <- thm +
    ggplot2::theme(...)

  return(thm)
}

#' A shorcut for making axis text flush with axis
#'
#' A shorcut for making axis text flush with axis
#'
#' @examples
#' library(ggplot2)
#' ggplot(mtcars) +
#'   geom_col(aes(y = mpg)) +
#'   scale_x_continuous(expand = flush_axis)
#' @family Making charts
#' @export
"flush_axis" <- ggplot2::expansion(mult = c(0, 0.05))
