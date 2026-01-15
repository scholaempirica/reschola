# A Schola Empirica ggplot2 theme

A wrapper around
[`theme()`](https://ggplot2.tidyverse.org/reference/theme.html) which
provides several shortcuts to setting common options and several
defaults. See more in Details.

## Usage

``` r
theme_schola(
  gridlines = c("y", "x", "both", "scatter"),
  base_size = 11,
  family = "Ubuntu Condensed",
  title_family = "Ubuntu",
  margins = TRUE,
  plot.title.position = "plot",
  axis_titles = TRUE,
  multiplot = FALSE,
  ...
)
```

## Arguments

- gridlines:

  Whether to display major gridlines along `"y"` (the default), `"x"`,
  `"both"` or draw a `"scatter"`, which has both gridlines and inverted
  colours.

- base_size:

  Numeric text size in pts, affects all text in plot. Defaults to 11.

- family, title_family:

  font family to use for the (title of the) plot. Defaults to `"Ubuntu"`
  for title and `"Ubuntu Condensed"` for plot.

- margins:

  *logical*, whether to draw margins around the plot or not (the
  default).

- plot.title.position:

  where to align the title. Either "plot" (the default, difference from
  [`theme()`](https://ggplot2.tidyverse.org/reference/theme.html)
  default) or `"panel"`.

- axis_titles:

  *logical*, draw axis titles? Defaults to `TRUE`.

- multiplot:

  if set to TRUE, provides better styling for small multiples created
  using `facet_*`.

- ...:

  Arguments passed on to
  [`ggplot2::theme`](https://ggplot2.tidyverse.org/reference/theme.html)

  `line`

  :   all line elements
      ([`element_line()`](https://ggplot2.tidyverse.org/reference/element.html))

  `rect`

  :   all rectangular elements
      ([`element_rect()`](https://ggplot2.tidyverse.org/reference/element.html))

  `title`

  :   all title elements: plot, axes, legends
      ([`element_text()`](https://ggplot2.tidyverse.org/reference/element.html);
      inherits from `text`)

  `point`

  :   all point elements
      ([`element_point()`](https://ggplot2.tidyverse.org/reference/element.html))

  `polygon`

  :   all polygon elements
      ([`element_polygon()`](https://ggplot2.tidyverse.org/reference/element.html))

  `geom`

  :   defaults for geoms
      ([`element_geom()`](https://ggplot2.tidyverse.org/reference/element.html))

  `spacing`

  :   all spacings ([`unit()`](https://rdrr.io/r/grid/unit.html))

  `aspect.ratio`

  :   aspect ratio of the panel

  `axis.text,axis.text.x,axis.text.y,axis.text.x.top,axis.text.x.bottom,axis.text.y.left,axis.text.y.right,axis.text.theta,axis.text.r`

  :   tick labels along axes
      ([`element_text()`](https://ggplot2.tidyverse.org/reference/element.html)).
      Specify all axis tick labels (`axis.text`), tick labels by plane
      (using `axis.text.x` or `axis.text.y`), or individually for each
      axis (using `axis.text.x.bottom`, `axis.text.x.top`,
      `axis.text.y.left`, `axis.text.y.right`). `axis.text.*.*` inherits
      from `axis.text.*` which inherits from `axis.text`, which in turn
      inherits from `text`

  `axis.ticks,axis.ticks.x,axis.ticks.x.top,axis.ticks.x.bottom,axis.ticks.y,axis.ticks.y.left,axis.ticks.y.right,axis.ticks.theta,axis.ticks.r`

  :   tick marks along axes
      ([`element_line()`](https://ggplot2.tidyverse.org/reference/element.html)).
      Specify all tick marks (`axis.ticks`), ticks by plane (using
      `axis.ticks.x` or `axis.ticks.y`), or individually for each axis
      (using `axis.ticks.x.bottom`, `axis.ticks.x.top`,
      `axis.ticks.y.left`, `axis.ticks.y.right`). `axis.ticks.*.*`
      inherits from `axis.ticks.*` which inherits from `axis.ticks`,
      which in turn inherits from `line`

  `axis.minor.ticks.x.top,axis.minor.ticks.x.bottom,axis.minor.ticks.y.left,axis.minor.ticks.y.right,axis.minor.ticks.theta,axis.minor.ticks.r`

  :   minor tick marks along axes
      ([`element_line()`](https://ggplot2.tidyverse.org/reference/element.html)).
      `axis.minor.ticks.*.*` inherit from the corresponding major ticks
      `axis.ticks.*.*`.

  `axis.ticks.length,axis.ticks.length.x,axis.ticks.length.x.top,axis.ticks.length.x.bottom,axis.ticks.length.y,axis.ticks.length.y.left,axis.ticks.length.y.right,axis.ticks.length.theta,axis.ticks.length.r`

  :   length of tick marks (`unit`). `axis.ticks.length` inherits from
      `spacing`.

  `axis.minor.ticks.length,axis.minor.ticks.length.x,axis.minor.ticks.length.x.top,axis.minor.ticks.length.x.bottom,axis.minor.ticks.length.y,axis.minor.ticks.length.y.left,axis.minor.ticks.length.y.right,axis.minor.ticks.length.theta,axis.minor.ticks.length.r`

  :   length of minor tick marks (`unit`), or relative to
      `axis.ticks.length` when provided with
      [`rel()`](https://ggplot2.tidyverse.org/reference/element.html).

  `axis.line,axis.line.x,axis.line.x.top,axis.line.x.bottom,axis.line.y,axis.line.y.left,axis.line.y.right,axis.line.theta,axis.line.r`

  :   lines along axes
      ([`element_line()`](https://ggplot2.tidyverse.org/reference/element.html)).
      Specify lines along all axes (`axis.line`), lines for each plane
      (using `axis.line.x` or `axis.line.y`), or individually for each
      axis (using `axis.line.x.bottom`, `axis.line.x.top`,
      `axis.line.y.left`, `axis.line.y.right`). `axis.line.*.*` inherits
      from `axis.line.*` which inherits from `axis.line`, which in turn
      inherits from `line`

  `legend.background`

  :   background of legend
      ([`element_rect()`](https://ggplot2.tidyverse.org/reference/element.html);
      inherits from `rect`)

  `legend.margin`

  :   the margin around each legend
      ([`margin()`](https://ggplot2.tidyverse.org/reference/element.html));
      inherits from `margins`.

  `legend.spacing,legend.spacing.x,legend.spacing.y`

  :   the spacing between legends (`unit`). `legend.spacing.x` &
      `legend.spacing.y` inherit from `legend.spacing` or can be
      specified separately. `legend.spacing` inherits from `spacing`.

  `legend.key`

  :   background underneath legend keys
      ([`element_rect()`](https://ggplot2.tidyverse.org/reference/element.html);
      inherits from `rect`)

  `legend.key.size,legend.key.height,legend.key.width`

  :   size of legend keys (`unit`); key background height & width
      inherit from `legend.key.size` or can be specified separately. In
      turn `legend.key.size` inherits from `spacing`.

  `legend.key.spacing,legend.key.spacing.x,legend.key.spacing.y`

  :   spacing between legend keys given as a `unit`. Spacing in the
      horizontal (x) and vertical (y) direction inherit from
      `legend.key.spacing` or can be specified separately.
      `legend.key.spacing` inherits from `spacing`.

  `legend.key.justification`

  :   Justification for positioning legend keys when more space is
      available than needed for display. The default, `NULL`, stretches
      keys into the available space. Can be a location like `"center"`
      or `"top"`, or a two-element numeric vector.

  `legend.frame`

  :   frame drawn around the bar
      ([`element_rect()`](https://ggplot2.tidyverse.org/reference/element.html)).

  `legend.ticks`

  :   tick marks shown along bars or axes
      ([`element_line()`](https://ggplot2.tidyverse.org/reference/element.html))

  `legend.ticks.length`

  :   length of tick marks in legend
      ([`unit()`](https://rdrr.io/r/grid/unit.html)); inherits from
      `legend.key.size`.

  `legend.axis.line`

  :   lines along axes in legends
      ([`element_line()`](https://ggplot2.tidyverse.org/reference/element.html))

  `legend.text`

  :   legend item labels
      ([`element_text()`](https://ggplot2.tidyverse.org/reference/element.html);
      inherits from `text`)

  `legend.text.position`

  :   placement of legend text relative to legend keys or bars ("top",
      "right", "bottom" or "left"). The legend text placement might be
      incompatible with the legend's direction for some guides.

  `legend.title`

  :   title of legend
      ([`element_text()`](https://ggplot2.tidyverse.org/reference/element.html);
      inherits from `title`)

  `legend.title.position`

  :   placement of legend title relative to the main legend ("top",
      "right", "bottom" or "left").

  `legend.position`

  :   the default position of legends ("none", "left", "right",
      "bottom", "top", "inside")

  `legend.position.inside`

  :   A numeric vector of length two setting the placement of legends
      that have the `"inside"` position.

  `legend.direction`

  :   layout of items in legends ("horizontal" or "vertical")

  `legend.byrow`

  :   whether the legend-matrix is filled by columns (`FALSE`, the
      default) or by rows (`TRUE`).

  `legend.justification`

  :   anchor point for positioning legend inside plot ("center" or
      two-element numeric vector) or the justification according to the
      plot area when positioned outside the plot

  `legend.justification.top,legend.justification.bottom,legend.justification.left,legend.justification.right,legend.justification.inside`

  :   Same as `legend.justification` but specified per `legend.position`
      option.

  `legend.location`

  :   Relative placement of legends outside the plot as a string. Can be
      `"panel"` (default) to align legends to the panels or `"plot"` to
      align legends to the plot as a whole.

  `legend.box`

  :   arrangement of multiple legends ("horizontal" or "vertical")

  `legend.box.just`

  :   justification of each legend within the overall bounding box, when
      there are multiple legends ("top", "bottom", "left", "right",
      "center" or "centre")

  `legend.box.margin`

  :   margins around the full legend area, as specified using
      [`margin()`](https://ggplot2.tidyverse.org/reference/element.html);
      inherits from `margins`.

  `legend.box.background`

  :   background of legend area
      ([`element_rect()`](https://ggplot2.tidyverse.org/reference/element.html);
      inherits from `rect`)

  `legend.box.spacing`

  :   The spacing between the plotting area and the legend box (`unit`);
      inherits from `spacing`.

  `panel.border`

  :   border around plotting area, drawn on top of plot so that it
      covers tick marks and grid lines. This should be used with
      `fill = NA`
      ([`element_rect()`](https://ggplot2.tidyverse.org/reference/element.html);
      inherits from `rect`)

  `panel.spacing,panel.spacing.x,panel.spacing.y`

  :   spacing between facet panels (`unit`). `panel.spacing.x` &
      `panel.spacing.y` inherit from `panel.spacing` or can be specified
      separately. `panel.spacing` inherits from `spacing`.

  `panel.ontop`

  :   option to place the panel (background, gridlines) over the data
      layers (`logical`). Usually used with a transparent or blank
      `panel.background`.

  `panel.widths,panel.heights`

  :   Sizes for panels (`units`). Can be a single unit to set the total
      size for the panel area, or a unit vector to set the size of
      individual panels. Using this setting overrides the aspect ratio
      set by the theme, coord or facets. An exception is made when the
      plot has a single panel and exactly one of the width *or* height
      is set, in which case an attempt is made to preserve the aspect
      ratio.

  `plot.background`

  :   background of the entire plot
      ([`element_rect()`](https://ggplot2.tidyverse.org/reference/element.html);
      inherits from `rect`)

  `plot.title.position,plot.caption.position`

  :   Alignment of the plot title/subtitle and caption. The setting for
      `plot.title.position` applies to both the title and the subtitle.
      A value of "panel" (the default) means that titles and/or caption
      are aligned to the plot panels. A value of "plot" means that
      titles and/or caption are aligned to the entire plot (minus any
      space for margins and plot tag).

  `plot.subtitle`

  :   plot subtitle (text appearance)
      ([`element_text()`](https://ggplot2.tidyverse.org/reference/element.html);
      inherits from `title`) left-aligned by default

  `plot.caption`

  :   caption below the plot (text appearance)
      ([`element_text()`](https://ggplot2.tidyverse.org/reference/element.html);
      inherits from `title`) right-aligned by default

  `plot.tag`

  :   upper-left label to identify a plot (text appearance)
      ([`element_text()`](https://ggplot2.tidyverse.org/reference/element.html);
      inherits from `title`) left-aligned by default

  `plot.tag.position`

  :   The position of the tag as a string ("topleft", "top", "topright",
      "left", "right", "bottomleft", "bottom", "bottomright") or a
      coordinate. If a coordinate, can be a numeric vector of length 2
      to set the x,y-coordinate relative to the whole plot. The
      coordinate option is unavailable for
      `plot.tag.location = "margin"`.

  `plot.tag.location`

  :   The placement of the tag as a string, one of `"panel"`, `"plot"`
      or `"margin"`. Respectively, these will place the tag inside the
      panel space, anywhere in the plot as a whole, or in the margin
      around the panel space.

  `strip.clip`

  :   should strip background edges and strip labels be clipped to the
      extend of the strip background? Options are `"on"` to clip,
      `"off"` to disable clipping or `"inherit"` (default) to take the
      clipping setting from the parent viewport.

  `strip.placement`

  :   placement of strip with respect to axes, either "inside" or
      "outside". Only important when axes and strips are on the same
      side of the plot.

  `strip.text,strip.text.x,strip.text.y,strip.text.x.top,strip.text.x.bottom,strip.text.y.left,strip.text.y.right`

  :   facet labels
      ([`element_text()`](https://ggplot2.tidyverse.org/reference/element.html);
      inherits from `text`). Horizontal facet labels (`strip.text.x`) &
      vertical facet labels (`strip.text.y`) inherit from `strip.text`
      or can be specified separately. Facet strips have dedicated
      position-dependent theme elements (`strip.text.x.top`,
      `strip.text.x.bottom`, `strip.text.y.left`, `strip.text.y.right`)
      that inherit from `strip.text.x` and `strip.text.y`, respectively.
      As a consequence, some theme stylings need to be applied to the
      position-dependent elements rather than to the parent elements

  `strip.switch.pad.grid,strip.switch.pad.wrap`

  :   space between strips and axes when strips are switched (`unit`);
      inherits from `spacing`.

  `complete`

  :   set this to `TRUE` if this is a complete theme, such as the one
      returned by
      [`theme_grey()`](https://ggplot2.tidyverse.org/reference/ggtheme.html).
      Complete themes behave differently when added to a ggplot object.
      Also, when setting `complete = TRUE` all elements will be set to
      inherit from blank elements.

  `validate`

  :   `TRUE` to run `check_element()`, `FALSE` to bypass checks.

## Value

a ggtheme object

## Details

In particular, the theme: - displays only major gridlines, allowing you
to quickly switch which ones; gridlines are thinner, panel has white
background

- provides quick option to draw a scatter with grey background -
  switches defaults for title alignment - turns axis labels off by
  default: in practice, x axes are often obvious and y axes are better
  documented in a subtitle - sets backgrounds to a schola-style shade -
  sets plot title in bold and 120% of base_size

All the changed defaults can be overriden by another call to
[`theme()`](https://ggplot2.tidyverse.org/reference/theme.html).

See "Making charts" vignette for more complex examples:
[`vignette('charts', package = 'reschola')`](https://scholaempirica.github.io/reschola/articles/charts.md).

## Note

The default fonts - Ubuntu and Ubuntu Condensed - are contained in this
package and can be registered with the system using
[`register_reschola_fonts()`](https://scholaempirica.github.io/reschola/reference/register_reschola_fonts.md).
You should then install them onto your system like any font, using files
in the directories described in the
[`register_reschola_fonts()`](https://scholaempirica.github.io/reschola/reference/register_reschola_fonts.md)
messsage.

## See also

Other Making charts:
[`flush_axis`](https://scholaempirica.github.io/reschola/reference/flush_axis.md),
[`plot_lollipop()`](https://scholaempirica.github.io/reschola/reference/plot_lollipop.md),
[`prepare_lollipop_data()`](https://scholaempirica.github.io/reschola/reference/prepare_lollipop_data.md),
[`schola_barplot()`](https://scholaempirica.github.io/reschola/reference/schola_barplot.md)

## Examples

``` r
library(ggplot2)

# NOTE when `theme_schola()` is used in these examples, fonts
# are set to 'sans' to pass checks on computers without the
# Ubuntu included. If you have these fonts (see Note) you can
# leave these parameters at their default values.

use_reschola_fonts("sans")

# the basic plot for illustration, theme not used

p <- ggplot(mpg) +
  geom_bar(aes(y = class)) +
  labs(title = "Lots of cars", subtitle = "Count of numbers")

# using `theme_schola()` defaults

p +
  theme_schola("x", family = "sans", title_family = "sans")


# in combination with `flush_axis`:

p +
  theme_schola("x", family = "sans", title_family = "sans") +
  scale_x_continuous(expand = flush_axis)


# scatter

ggplot(mpg) +
  geom_point(aes(cty, hwy)) +
  theme_schola("scatter", family = "sans", title_family = "sans") +
  labs(title = "Lots of cars", subtitle = "Point by point")


# Smaller text, flush alignment

ggplot(mpg) +
  geom_point(aes(cty, hwy)) +
  theme_schola("scatter",
    base_size = 9, family = "sans", title_family = "sans"
  ) +
  labs(title = "Lots of cars", subtitle = "Point by point")


# Override defaults changed inside `theme_schola()`

ggplot(mpg) +
  geom_point(aes(cty, hwy)) +
  theme_schola("scatter",
    base_size = 9, family = "sans", title_family = "sans"
  ) +
  labs(title = "Lots of cars", subtitle = "Point by point") +
  theme(panel.background = element_rect(fill = "lightpink"))
```
