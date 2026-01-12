# Get labels of variables

Get labels of variables

## Usage

``` r
get_labs_df(.data)
```

## Arguments

- .data:

  tibble or data.frame

## Value

tibble with variables and its labels (as list-column)

## Examples

``` r
# make labels for iris dataset, labels will be colnames
# with dot replaced for whitespace
iris_with_labs <- as.data.frame(mapply(function(x, y) {
  attr(x, "label") <- y
  return(x)
}, iris, gsub("\\.", " ", colnames(iris)), SIMPLIFY = FALSE))

get_labs_df(iris_with_labs)
#> # A tibble: 5 × 2
#>   variable     label    
#>   <chr>        <list>   
#> 1 Sepal.Length <chr [1]>
#> 2 Sepal.Width  <chr [1]>
#> 3 Petal.Length <chr [1]>
#> 4 Petal.Width  <chr [1]>
#> 5 Species      <chr [1]>
```
