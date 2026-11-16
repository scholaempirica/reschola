# Continuous position scales with Czech number and percent labels

These are
[`ggplot2::scale_x_continuous()`](https://ggplot2.tidyverse.org/reference/scale_continuous.html)
and
[`ggplot2::scale_y_continuous()`](https://ggplot2.tidyverse.org/reference/scale_continuous.html)
with Czech label defaults (decimal comma, space as the thousands
separator, `" %"` suffix for percentages), so you don't have to set them
repeatedly. The arguments you would normally pass to a
`scales::label_*()` function are available directly.

## Usage

``` r
scale_x_percent_cz(
  name = waiver(),
  ...,
  labels,
  limits = NULL,
  expand = c(0.01, 0),
  oob = scales::censor,
  position = "bottom",
  accuracy = 1,
  scale = 100,
  prefix = "",
  suffix = " %",
  big.mark = " ",
  decimal.mark = ",",
  trim = TRUE
)

scale_y_percent_cz(
  name = waiver(),
  ...,
  labels,
  limits = NULL,
  expand = c(0.01, 0),
  oob = scales::censor,
  position = "left",
  accuracy = 1,
  scale = 100,
  prefix = "",
  suffix = " %",
  big.mark = " ",
  decimal.mark = ",",
  trim = TRUE
)

scale_x_number_cz(
  name = waiver(),
  ...,
  labels,
  limits = NULL,
  expand = c(0.01, 0),
  oob = scales::censor,
  position = "bottom",
  accuracy = 1,
  scale = 1,
  prefix = "",
  suffix = "",
  big.mark = " ",
  decimal.mark = ",",
  trim = TRUE
)

scale_y_number_cz(
  name = waiver(),
  ...,
  labels,
  limits = NULL,
  expand = c(0.01, 0),
  oob = scales::censor,
  position = "left",
  accuracy = 1,
  scale = 1,
  prefix = "",
  suffix = "",
  big.mark = " ",
  decimal.mark = ",",
  trim = TRUE
)
```

## Arguments

- name:

  The name of the scale. Used as the axis or legend title. If
  [`waiver()`](https://ggplot2.tidyverse.org/reference/waiver.html), the
  default, the name of the scale is taken from the first mapping used
  for that aesthetic. If `NULL`, the legend title will be omitted.

- ...:

  Other arguments passed on to
  [`ggplot2::scale_x_continuous()`](https://ggplot2.tidyverse.org/reference/scale_continuous.html)
  or
  [`ggplot2::scale_y_continuous()`](https://ggplot2.tidyverse.org/reference/scale_continuous.html),
  e.g. `breaks`, `n.breaks`, `transform` or `sec.axis`.

- labels:

  Overrides the default labels built from `accuracy`, `scale`, `prefix`,
  `suffix`, `big.mark`, `decimal.mark` and `trim`. Accepts anything
  [`ggplot2::scale_x_continuous()`](https://ggplot2.tidyverse.org/reference/scale_continuous.html)
  does, e.g. `NULL` for no labels or a labelling function such as
  [`label_number_cz()`](https://scholaempirica.github.io/reschola/reference/formatscz.md).

- limits:

  One of:

  - `NULL` to use the default scale range

  - A numeric vector of length two providing limits of the scale. Use
    `NA` to refer to the existing minimum or maximum

  - A function that accepts the existing (automatic) limits and returns
    new limits. Also accepts rlang
    [lambda](https://rlang.r-lib.org/reference/as_function.html)
    function notation. Note that setting limits on positional scales
    will **remove** data outside of the limits. If the purpose is to
    zoom, use the limit argument in the coordinate system (see
    [`coord_cartesian()`](https://ggplot2.tidyverse.org/reference/coord_cartesian.html)).

- expand:

  For position scales, a vector of range expansion constants used to add
  some padding around the data to ensure that they are placed some
  distance away from the axes. Use the convenience function
  [`expansion()`](https://ggplot2.tidyverse.org/reference/expansion.html)
  to generate the values for the `expand` argument. The defaults are to
  expand the scale by 5% on each side for continuous variables, and by
  0.6 units on each side for discrete variables.

- oob:

  One of:

  - Function that handles limits outside of the scale limits (out of
    bounds). Also accepts rlang
    [lambda](https://rlang.r-lib.org/reference/as_function.html)
    function notation.

  - The default
    ([`scales::censor()`](https://scales.r-lib.org/reference/oob.html))
    replaces out of bounds values with `NA`.

  - [`scales::squish()`](https://scales.r-lib.org/reference/oob.html)
    for squishing out of bounds values into range.

  - [`scales::squish_infinite()`](https://scales.r-lib.org/reference/oob.html)
    for squishing infinite values into range.

- position:

  For position scales, The position of the axis. `left` or `right` for y
  axes, `top` or `bottom` for x axes.

- accuracy:

  A number to round to. Use (e.g.) `0.01` to show 2 decimal places of
  precision. If `NULL`, the default, uses a heuristic that should ensure
  breaks have the minimum number of digits needed to show the difference
  between adjacent values.

  Applied to rescaled data.

- scale:

  A scaling factor: `x` will be multiplied by `scale` before formatting.
  This is useful if the underlying data is very small or very large.

- prefix:

  Additional text to display before the number. The suffix is applied to
  absolute value before `style_positive` and `style_negative` are
  processed so that `prefix = "$"` will yield (e.g.) `-$1` and `($1)`.

- suffix:

  Additional text to display after the number.

- big.mark:

  Character used between every 3 digits to separate thousands. The
  default (`NULL`) retrieves the setting from the [number
  options](https://scales.r-lib.org/reference/number_options.html).

- decimal.mark:

  The character to be used to indicate the numeric decimal point. The
  default (`NULL`) retrieves the setting from the [number
  options](https://scales.r-lib.org/reference/number_options.html).

- trim:

  Logical, if `FALSE`, values are right-justified to a common width (see
  [`base::format()`](https://rdrr.io/r/base/format.html)).

## Value

A ggplot2 scale.

## Examples

``` r
library(reschola)
library(ggplot2)
ggplot(mpg, aes(hwy * 100, cty / max(cty))) +
  geom_point() +
  theme_schola(family = "sans", title_family = "sans", gridlines = "scatter") +
  scale_y_percent_cz() +
  scale_x_number_cz()
```
