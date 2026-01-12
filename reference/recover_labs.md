# Recover lost labels from same-structured tibble with labels

Many operations, such as [rbind](https://rdrr.io/r/base/cbind.html),
[cbind](https://rdrr.io/r/base/cbind.html) or its tidyverse analogues,
strips out the variable labels. Use `recover_labs()` to bring them back
from a `tibble` or `data.frame` where they are last present. The
function attempts a few checks for new and original data compatibility.
Note that the infix operator is available for a quick and
self-explanatory usage.

## Usage

``` r
recover_labs(new_data, orig_data)

new_data %labs_from% orig_data
```

## Arguments

- new_data:

  new dataframe that you want to recover the labs for

- orig_data:

  original dataframe with variable labels present

## Value

Tibble or data.frame with variable labels restored.

## Examples

``` r
# make labels for iris dataset, labels will be colnames
# with dot replaced for whitespace
iris_with_labs <- as.data.frame(mapply(function(x, y) {
  attr(x, "label") <- y
  return(x)
}, iris, gsub("\\.", " ", colnames(iris)), SIMPLIFY = FALSE))

iris_with_recovered_labs <- recover_labs(iris, iris_with_labs)
iris_with_recovered_labs_infix <- iris %labs_from% iris_with_labs

# check
get_labs_df(iris_with_recovered_labs)
#> # A tibble: 5 × 2
#>   variable     label    
#>   <chr>        <list>   
#> 1 Sepal.Length <chr [1]>
#> 2 Sepal.Width  <chr [1]>
#> 3 Petal.Length <chr [1]>
#> 4 Petal.Width  <chr [1]>
#> 5 Species      <chr [1]>
get_labs_df(iris_with_recovered_labs_infix)
#> # A tibble: 5 × 2
#>   variable     label    
#>   <chr>        <list>   
#> 1 Sepal.Length <chr [1]>
#> 2 Sepal.Width  <chr [1]>
#> 3 Petal.Length <chr [1]>
#> 4 Petal.Width  <chr [1]>
#> 5 Species      <chr [1]>
```
