# Create HTML span tag with text and color style

Create HTML span tag with text and color style

## Usage

``` r
with_clr(text, color = "black", alpha = 1, ...)
```

## Arguments

- text:

  *character*, text that will be colored.

- color:

  *character*, color applied to the text, defaults to black.

- alpha:

  *numeric*, opacity in interval 0–1, where 1 is no transparency, i.e.
  full opacity

- ...:

  Arguments passed on to
  [`htmltools::span`](https://rstudio.github.io/htmltools/reference/builder.html)

  `.noWS`

  :   Character vector used to omit some of the whitespace that would
      normally be written around this tag. Valid options include
      `before`, `after`, `outside`, `after-begin`, and `before-end`. Any
      number of these options can be specified.

  `.renderHook`

  :   A function (or list of functions) to call when the `tag` is
      rendered. This function should have at least one argument (the
      `tag`) and return anything that can be converted into tags via
      [`as.tags()`](https://rstudio.github.io/htmltools/reference/as.tags.html).
      Additional hooks may also be added to a particular `tag` via
      [`tagAddRenderHook()`](https://rstudio.github.io/htmltools/reference/tagAddRenderHook.html).

## Value

an object of class `shiny.tag`, coercible to character

## Examples

``` r
html <- paste0(
  with_clr("Red", "red"), ", ",
  with_clr("green", "green"),
  " and ",
  with_clr("blue", "blue"),
  " are the basic colors."
)

library(ggplot2)
library(ggtext)

ggplot() +
  geom_richtext(aes(x = 1, y = 1, label = html), size = 8) +
  theme_void()

```
