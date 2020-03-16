
#' A Schola Empirica ggplot2 theme
#'
#' A wrapper around `theme()` which provides several shortcuts to setting common options
#' and several defaults. See more in Details.
#'
#' In particular, the theme:
#' - displays only major gridlines, allowing you to quickly switch which ones; gridlines are thinner, panel has white background
#' - provides quick option to draw a scatter with grey background
#' - switches defaults for title alignment
#' - turns axis labels off by default: in practice, x axes are often obvious and
#' y axes are better documented in a subtitle
#' - sets backgrounds to a schola-style shade
#' - sets plot title in bold and 120% of base_size
#'
#' All the changed defaults can be overrided by another call to `theme()`.
#'
#' See "Making charts" vignette for more complex examples: `vignette('charts', package = 'reschola')`.
#'
#' @param base_size Numeric text size in pts, affects all text in plot. Defaults to 11.
#' @param gridlines Whether to display major gridlines along `"y"` (the default),
#' `"x"`, `"both"` or draw a `"scatter"`, which has both gridlines and inverted colours.
#' @param family font family to use for the plot. Defaults to `"sans"`.
#' @param title_family font family to use for the title of the plot. Defaults to `"sans"`.
#' @param side_margin size of left and right margin around plot, in pts. Defaults to 5. Set to 0 to align flush with text in a Word document.
#' @param plot.title.position where to align the title. Either "plot" (the default, difference from `theme()` default) or `"panel"`.
#' @param axis.title same as in theme(), but with a default of `element_blank()`.
#' @param multiplot if set to TRUE, provides better styling for small multiples created using `facet_*`.
#' @param ... Other parameters to be passed to `theme()`.
#'
#' @return a ggtheme object
#' @family Making charts
#' @examples
#' library(ggplot2)
#'
#' # the basic plot for illustration, theme not used
#'
#' p <- ggplot(mpg) +
#'   geom_bar(aes(y = class)) +
#'   labs(title = "Lots of cars", subtitle = "Count of numbers")
#'
#' # using `theme_schola()` defaults
#'
#' p +
#'   theme_schola("x")
#'
#' # in combination with `flush_axis`:
#'
#' p +
#'   theme_schola("x") +
#'   scale_x_continuous(expand = flush_axis)
#'
#' # scatter
#'
#' ggplot(mpg) +
#'   geom_point(aes(cty, hwy)) +
#'   theme_schola("scatter") +
#'   labs(title = "Lots of cars", subtitle = "Point by point")
#'
#' # Smaller text, flush alignment
#'
#' ggplot(mpg) +
#'   geom_point(aes(cty, hwy)) +
#'   theme_schola("scatter", base_size = 9, side_margin = 0) +
#'   labs(title = "Lots of cars", subtitle = "Point by point")
#'
#' # Override defaults changed inside `theme_schola()`
#'
#' ggplot(mpg) +
#'   geom_point(aes(cty, hwy)) +
#'   theme_schola("scatter", base_size = 9, side_margin = 0) +
#'   labs(title = "Lots of cars", subtitle = "Point by point") +
#'   theme(panel.background = element_rect(fill = "lightpink"))
#'
#' @export
theme_schola <- function(gridlines = c("y", "x", "both", "scatter"),
                         base_size = 11,
                         family = "sans", title_family = family,
                         side_margin = 6,
                         plot.title.position = "plot",
                         axis.title = ggplot2::element_blank(),
                         multiplot = FALSE,
                         ...) {
  tonecol <- "#f6f0e8"
  grd <- match.arg(gridlines)
  grid_col <- if(grd == "scatter" | multiplot) "white" else "grey92"
  bg_col <- if(grd == "scatter" | multiplot) tonecol else "white"
  element_gridline <- ggplot2::element_line(colour = grid_col, size = 0.3)
  thm <- ggplot2::theme_minimal(base_size = base_size, base_family = family) +
    ggplot2::theme(plot.title.position = plot.title.position,
                   plot.title = ggplot2::element_text(face = "bold",
                                                      size = base_size * 1.2,
                                                      family = title_family),
                   panel.grid.minor = ggplot2::element_blank(),
                   panel.grid.major.x = if(grd != "y")
                     element_gridline else ggplot2::element_blank(),
                   panel.grid.major.y = if(grd != "x")
                     element_gridline else ggplot2::element_blank(),
                   # axis.line = ggplot2::element_line(),
                   panel.background = ggplot2::element_rect(fill = bg_col,
                                                            colour = NA),
                   axis.title = axis.title,
                   strip.text.x = ggplot2::element_text(hjust = 0),
                   plot.margin = ggplot2::unit(c(10, side_margin, 10, side_margin),
                                               units = "pt"))
  if(multiplot) thm <- thm +
    ggplot2::theme(strip.background = ggplot2::element_rect(fill = tonecol,
                                                            colour = NA))

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
#' ggplot(mpg) +
#'   geom_bar(aes(y = class)) +
#'   scale_x_continuous(expand = flush_axis)
#' @family Making charts
#' @export
"flush_axis" <- ggplot2::expansion(mult = c(0, 0.05))
