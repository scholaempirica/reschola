# Prepare data for `plot_lollipop()`

**\[maturing\]**

## Usage

``` r
prepare_lollipop_data(.data, vars, group)
```

## Arguments

- .data:

  tibble or data.frame with variables

- vars:

  variables to reshape from wide to long, uses tidyselect syntax

- group:

  grouping variable (have to be logical!), usually denoting for which
  school the plot should be tailored for

## Value

several tibbles inside list, intended for data-mining and for plotting

## See also

Other Making charts:
[`flush_axis`](https://scholaempirica.github.io/reschola/reference/flush_axis.md),
[`plot_lollipop()`](https://scholaempirica.github.io/reschola/reference/plot_lollipop.md),
[`schola_barplot()`](https://scholaempirica.github.io/reschola/reference/schola_barplot.md),
[`theme_schola()`](https://scholaempirica.github.io/reschola/reference/theme_schola.md)
