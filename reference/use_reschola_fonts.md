# Make ggplot2 use font(s) in text-based geoms

Sets `{ggplot2}` defaults for most text-based geoms in `{ggplot2}`,
`{ggtext}`, and `{ggrepel}`.

## Usage

``` r
use_reschola_fonts(
  family = "Ubuntu Condensed",
  face = "plain",
  size = 3.5,
  color = "#2b2b2b"
)

set_reschola_ggplot_fonts(
  family = "Ubuntu Condensed",
  face = "plain",
  size = 3.5,
  color = "#2b2b2b"
)
```

## Arguments

- family:

  font family, defaults to reschola recommended

- face:

  font face

- size:

  font size

- color:

  font color

## Details

Geoms covered: "text", "label", "richtext", "text_box", "text_repel",
and "label_repel".

## See also

Other Font helpers and shortcuts:
[`import_fonts()`](https://scholaempirica.github.io/reschola/reference/import_fonts.md),
[`install_reschola_fonts()`](https://scholaempirica.github.io/reschola/reference/install_reschola_fonts.md),
[`register_reschola_fonts()`](https://scholaempirica.github.io/reschola/reference/register_reschola_fonts.md)
