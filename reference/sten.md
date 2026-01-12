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
#>  [1] 7.370726 5.852977 5.987371 8.747098 5.724076 5.232006 1.679825 4.941526
#>  [9] 4.873108 7.634616
```
