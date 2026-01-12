# A shorcut for making axis text flush with axis

A shorcut for making axis text flush with axis

## Usage

``` r
flush_axis
```

## Format

An object of class `numeric` of length 4.

## See also

Other Making charts:
[`plot_lollipop()`](https://scholaempirica.github.io/reschola/reference/plot_lollipop.md),
[`prepare_lollipop_data()`](https://scholaempirica.github.io/reschola/reference/prepare_lollipop_data.md),
[`schola_barplot()`](https://scholaempirica.github.io/reschola/reference/schola_barplot.md),
[`theme_schola()`](https://scholaempirica.github.io/reschola/reference/theme_schola.md)

## Examples

``` r
library(ggplot2)
ggplot(mpg) +
  geom_bar(aes(y = class)) +
  scale_x_continuous(expand = flush_axis)
```
