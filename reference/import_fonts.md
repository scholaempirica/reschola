# Import Ubuntu fonts for use in charts and in the PDF reports

**\[deprecated\]**

The function relies on `{extrafont}` package that comes with briken
dependencies at the moment. An experimental
[`register_reschola_fonts()`](https://scholaempirica.github.io/reschola/reference/register_reschola_fonts.md)
is proposed.

## Usage

``` r
import_fonts()
```

## Source

Fonts are licensed under the [Ubuntu Font
License](https://ubuntu.com/legal/font-licence).

## Details

This is an analogue of
[`hrbrthemes::import_roboto_condensed()`](https://rdrr.io/pkg/hrbrthemes/man/import_roboto_condensed.html).

There is an option `reschola.loadfonts` which – if set to `TRUE` – will
call
[`extrafont::loadfonts()`](https://rdrr.io/pkg/extrafont/man/loadfonts.html)
to register non-core fonts with R PDF & PostScript devices. If you are
running under Windows, the package calls the same function to register
non-core fonts with the Windows graphics device.

## Note

If you install the fonts just for the current user (via right-click and
Install), they will probably **not be discoverable** by the `fontspec`
LaTeX package that is used for PDF report typesetting!

## See also

Other Font helpers and shortcuts:
[`install_reschola_fonts()`](https://scholaempirica.github.io/reschola/reference/install_reschola_fonts.md),
[`register_reschola_fonts()`](https://scholaempirica.github.io/reschola/reference/register_reschola_fonts.md),
[`use_reschola_fonts()`](https://scholaempirica.github.io/reschola/reference/use_reschola_fonts.md)
