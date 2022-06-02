
#' A Schola Empirica ggplot2 theme
#'
#' A wrapper around `theme()` which provides several shortcuts to setting common
#' options and several defaults. See more in Details.
#'
#' In particular, the theme: - displays only major gridlines, allowing you to
#' quickly switch which ones; gridlines are thinner, panel has white background
#' - provides quick option to draw a scatter with grey background - switches
#' defaults for title alignment - turns axis labels off by default: in practice,
#' x axes are often obvious and y axes are better documented in a subtitle -
#' sets backgrounds to a schola-style shade - sets plot title in bold and 120%
#' of base_size
#'
#' All the changed defaults can be overriden by another call to `theme()`.
#'
#' See "Making charts" vignette for more complex examples: `vignette('charts',
#' package = 'reschola')`.
#'
#' @note The default fonts - Ubuntu and Ubuntu Condensed - are contained in this
#'   package and can be registered with the system using
#'   `register_reschola_fonts()`. You should then install them onto your system
#'   like any font, using files in the directories described in the
#'   `register_reschola_fonts()` messsage.
#'
#' @param base_size Numeric text size in pts, affects all text in plot. Defaults
#'   to 11.
#' @param gridlines Whether to display major gridlines along `"y"` (the
#'   default), `"x"`, `"both"` or draw a `"scatter"`, which has both gridlines
#'   and inverted colours.
#' @param family,title_family font family to use for the (title of the) plot.
#'   Defaults to `"Ubuntu"` for title and `"Ubuntu Condensed"` for plot.
#' @param margins *logical*, whether to draw margins around the plot or not (the
#'   default).
#' @param plot.title.position where to align the title. Either "plot" (the
#'   default, difference from `theme()` default) or `"panel"`.
#' @param axis_titles *logical*, draw axis titles? Defaults to `TRUE`.
#' @param multiplot if set to TRUE, provides better styling for small multiples
#'   created using `facet_*`.
#' @inheritDotParams ggplot2::theme -text -plot.title -panel.grid.minor
#'   -panel.grid.major.x -panel.grid.major.y -panel.background -axis.title
#'   -strip.text.x -plot.margin -strip.background
#'
#' @return a ggtheme object
#' @family Making charts
#' @examples
#' library(ggplot2)
#'
#' # NOTE when `theme_schola()` is used in these examples, fonts
#' # are set to 'sans' to pass checks on computers without the
#' # Ubuntu included. If you have these fonts (see Note) you can
#' # leave these parameters at their default values.
#'
#' use_reschola_fonts("sans")
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
#'   theme_schola("x", family = "sans", title_family = "sans")
#'
#' # in combination with `flush_axis`:
#'
#' p +
#'   theme_schola("x", family = "sans", title_family = "sans") +
#'   scale_x_continuous(expand = flush_axis)
#'
#' # scatter
#'
#' ggplot(mpg) +
#'   geom_point(aes(cty, hwy)) +
#'   theme_schola("scatter", family = "sans", title_family = "sans") +
#'   labs(title = "Lots of cars", subtitle = "Point by point")
#'
#' # Smaller text, flush alignment
#'
#' ggplot(mpg) +
#'   geom_point(aes(cty, hwy)) +
#'   theme_schola("scatter",
#'     base_size = 9, family = "sans", title_family = "sans"
#'   ) +
#'   labs(title = "Lots of cars", subtitle = "Point by point")
#'
#' # Override defaults changed inside `theme_schola()`
#'
#' ggplot(mpg) +
#'   geom_point(aes(cty, hwy)) +
#'   theme_schola("scatter",
#'     base_size = 9, family = "sans", title_family = "sans"
#'   ) +
#'   labs(title = "Lots of cars", subtitle = "Point by point") +
#'   theme(panel.background = element_rect(fill = "lightpink"))
#' @import ggplot2
#' @importFrom ggtext element_textbox_simple
#' @export
theme_schola <- function(gridlines = c("y", "x", "both", "scatter"), base_size = 11,
                         family = "Ubuntu Condensed", title_family = "Ubuntu",
                         margins = TRUE, plot.title.position = "plot",
                         axis_titles = TRUE, multiplot = FALSE, ...) {
  grd <- match.arg(gridlines)
  grid_col <- if (grd == "scatter" | multiplot) {
    "white"
  } else {
    "grey92"
  }
  tonecol <- "#f6f0e8"
  element_gridline <- element_line(colour = grid_col, size = 0.3)
  bg_col <- if (grd == "scatter" | multiplot) {
    tonecol
  } else {
    "white"
  }

  base_theme <- theme_minimal(base_size = base_size, base_family = family)

  schola_theme <- theme(
    plot.title.position = plot.title.position,
    text = element_text(colour = "grey30"),
    plot.title = element_textbox_simple(
      face = "bold", size = base_size * 1.2, family = title_family,
      lineheight = 1.1, margin = margin(b = 6)
    ),
    panel.grid.minor = element_blank(),
    panel.grid.major.x = if (grd != "y") element_gridline else element_blank(),
    panel.grid.major.y = if (grd != "x") element_gridline else element_blank(),
    panel.background = element_rect(fill = bg_col, colour = NA),
    axis.title = if (axis_titles) element_text() else element_blank(),
    strip.text = element_text(hjust = 0),
    plot.margin = if (margins) margin(t = 4) else base_theme$plot.margin, # top margin because of title grob heigh is incorrect
    strip.background = if (multiplot) element_rect(fill = tonecol, colour = NA) else element_blank(),
    plot.subtitle = element_textbox_simple(family = title_family, lineheight = 1.1, margin = margin(b = 6)),
    plot.caption = element_textbox_simple(
      colour = "grey55", lineheight = 1, halign = 1, margin = margin(t = 5)
    ),
    ...
  )
  base_theme + schola_theme
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
