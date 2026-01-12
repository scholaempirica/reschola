# Czech Date Interval

Returns the most space-efficient and at the same time grammatically
correct interval of two Czech dates. When both dates are the same, only
one is outputted. The function ensures that the interval is not negative
(i.e., `start` \<= `end`), otherwise, it is reversed.

## Usage

``` r
czech_date_interval(start, end)
```

## Arguments

- start:

  *Date of date-like object*, start date or left boundary of an
  interval.

- end:

  *Date of date-like object*, end date or right boundary of an interval.

## Value

Character

## Examples

``` r
czech_date_interval("2020-01-24", "2020-01-03") # note the argument order
#> [1] "3.–24. ledna 2020"
```
