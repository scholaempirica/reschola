# Register reschola fonts on Windows

**\[stable\]**

The function is only for Windows, where it tries to register font family
provided with "Windows bitmap device". On other platforms, fonts
*should* be readily available after installation. Note that even on
Windows, you can instruct RStudio to use smarter graphics device, such
as "AGG" or "Cairo" (*Tools \> Global Options \> General \> Graphics \>
Backend*).

## Usage

``` r
register_reschola_fonts(family = c("Ubuntu", "Ubuntu Condensed"))
```

## Arguments

- family:

  font family/families to register, default is reschola recommended.

## Value

Called for side effects, but returns logical on process result
invisibly.

## See also

Other Font helpers and shortcuts:
[`import_fonts()`](https://scholaempirica.github.io/reschola/reference/import_fonts.md),
[`install_reschola_fonts()`](https://scholaempirica.github.io/reschola/reference/install_reschola_fonts.md),
[`use_reschola_fonts()`](https://scholaempirica.github.io/reschola/reference/use_reschola_fonts.md)
