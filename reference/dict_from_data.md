# Get item code-label dictionary from data

Item labels have to be stored as variable attribute `label`. Exported by
default by
[`ls_export()`](https://scholaempirica.github.io/reschola/reference/ls_export.md),
but many data wrangling operations strip them out, unfortunately.

## Usage

``` r
dict_from_data(.data)
```

## Arguments

- .data:

  data.frame or tibble

## Value

named character vector of items' labels, if no label found, NULL is
introduced and is omitted in the output
