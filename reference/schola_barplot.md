# Plot standard Schola likert-like barplot with groupwise comparison per items

**\[maturing\]**

## Usage

``` r
schola_barplot(
  .data,
  vars,
  group,
  dict = dict_from_data(.data),
  escape_level = "nevím",
  n_breaks = 11,
  desc = TRUE,
  labels = TRUE,
  min_label_width = 0.09,
  absolute_counts = TRUE,
  fill_cols = NULL,
  fill_labels = waiver(),
  facet_label_wrap = 115,
  reverse = FALSE,
  order_by = "chi-square differences",
  drop = FALSE,
  drop_na = TRUE,
  show.legend = TRUE,
  ...
)
```

## Arguments

- .data:

  data with items and group variable

- vars:

  vector of items, supports `{tidyselect}` syntax (i.e, non-standard
  evaluation)

- group:

  group variable used to split the results, have to be logical, where
  `TRUE` is gonna be considered as "focal" group and displayed as upper
  group Supports `{tidyselect}` syntax.

- dict:

  item code-label dictionary, if none provided, those are derived from
  the data.

- escape_level:

  *character*, level of item response considered as NA

- n_breaks:

  number of breaks displayed at x-axis, outer labels are automatically
  aligned to face inward. Defaults to 11, which results in 10% wide
  breaks.

- desc:

  sor items in descending order?

- labels:

  draw labels?

- min_label_width:

  smallest percentage (0-1) to display in the plot, proportions larger
  than this value are shown, smaller are not.

- absolute_counts:

  draw labels and absolute counts in parentheses?

- fill_cols:

  colors to be used for item categories, defaults to NULL, meaning
  standard RdYlBu palette will be used

- fill_labels:

  character vector or function taking breaks and returning labels for
  fill aesthetic

- facet_label_wrap:

  width of facet label to wrap

- reverse:

  if TRUE, reverse colors

- order_by:

  how to order the items. chi-square differences (default) computes
  chi-square test for every item and sort them by largest X2 statistic
  to smallest (if desc = TRUE)

- drop:

  Drop unobserved levels form the legend? Defaults to `FALSE`. See
  [ggplot2::discrete_scale](https://ggplot2.tidyverse.org/reference/discrete_scale.html)
  for more details. To always show the legend key, make sure you have
  `show.legend` set to `TRUE` as well (as done by default).

- drop_na:

  Drop `NA`s from every item (a.k.a. "pairwise")? Defaults to `TRUE`.
  Note that the number of observations per item may differ, because `NA`
  in one item does not mean the respondent row is discarded completely
  (listwise).

- show.legend:

  logical. Should this layer be included in the legends? `NA`, the
  default, includes if any aesthetics are mapped. `FALSE` never
  includes, and `TRUE` always includes. It can also be a named logical
  vector to finely select the aesthetics to display. To include legend
  keys for all levels, even when no data exists, use `TRUE`. If `NA`,
  all levels are shown in legend, but unobserved levels are omitted.

- ...:

  Arguments passed on to
  [`fct_nanify`](https://scholaempirica.github.io/reschola/reference/fct_nanify.md)

  `negate`

  :   *logical*, whether to return non-matching elements. Defaults to
      `FALSE`.

  `ignore_case`

  :   *logical*, ignore case when matching? Defaults to `TRUE`.

## Value

Object of class "gg", "ggplot".

## See also

Other Making charts:
[`flush_axis`](https://scholaempirica.github.io/reschola/reference/flush_axis.md),
[`plot_lollipop()`](https://scholaempirica.github.io/reschola/reference/plot_lollipop.md),
[`prepare_lollipop_data()`](https://scholaempirica.github.io/reschola/reference/prepare_lollipop_data.md),
[`theme_schola()`](https://scholaempirica.github.io/reschola/reference/theme_schola.md)
