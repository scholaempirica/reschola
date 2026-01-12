# Labeller with width wrapping and item code-label dictionary

Turns item codes into labels by looking up provided dictionary and
applies them as facet labels.

## Usage

``` r
schola_labeller(dict, width = 80)
```

## Arguments

- dict:

  code-label dictionary as named character vector, see
  [`dict_from_data()`](https://scholaempirica.github.io/reschola/reference/dict_from_data.md)

- width:

  maximal string length per line, if `NULL`, this is off

## Value

object of class `labeller`, to be used in `facet_*` `{ggplot2}`
functions.
