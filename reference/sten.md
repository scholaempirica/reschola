# Transform to STEN score (Standard Ten)

Get your raw total score transformed to stens, i.e., with the mean of
5.5 and a standard deviation of 2. See the [Wikipedia
article](https://en.wikipedia.org/wiki/Sten_scores) on the topic for
more details.

## Usage

``` r
sten(score, standardize = FALSE, bounds = TRUE)
```

## Arguments

- score:

  *numeric* vector of scores to transform

- standardize:

  *logical*, center and scale `score` vector before the transformation?
  Defaults to `FALSE`.

- bounds:

  limit result to 1-10 scale, TRUE by default

## Value

*numeric* vector of transformed scores

## Examples

``` r
rnorm(10) |> sten()
#>  [1] 2.699913 6.010634 1.000000 5.488857 6.743105 7.796823 1.856365 5.005349
#>  [9] 5.011601 4.934589
```
