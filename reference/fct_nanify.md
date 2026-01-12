# NAnify factor level

The inverse of `fct_explicit_na()`. Turns the `level` into proper `NA`.
**Retains the level.**

## Usage

``` r
fct_nanify(f, level, negate = FALSE, ignore_case = TRUE)
```

## Arguments

- f:

  *factor* to work on

- level:

  *character*, regular expression matching the desired level

- negate:

  *logical*, whether to return non-matching elements. Defaults to
  `FALSE`.

- ignore_case:

  *logical*, ignore case when matching? Defaults to `TRUE`.

## Value

*factor* with NA-substituted level.

## Examples

``` r
f <- factor(c("a", "b", "c", "nanify"))
fct_nanify(f, "nanify")
#> 
#> ℹ Before coercing to integer, make sure the level you have just NAnified is the last one, so no number is skipped!
#> This message is displayed once per session.
#> [1] a    b    c    <NA>
#> Levels: a b c nanify
```
