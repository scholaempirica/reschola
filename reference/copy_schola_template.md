# Copy default Schola template into project directory

Copy default Schola template into project directory

## Usage

``` r
copy_schola_template(format = "pdf", path = proj_get(), ...)
```

## Arguments

- format:

  *Character*, format which to look for. Defaults to `pdf`.

- path:

  *Character*, path to copy to. Defaults to the current project root.

- ...:

  Arguments passed on to
  [`base::file.copy`](https://rdrr.io/r/base/files.html)

  `overwrite`

  :   logical; should existing destination files be overwritten?

  `recursive`

  :   logical. If `to` is a directory, should directories in `from` be
      copied (and their contents)? (Like `cp -R` on POSIX OSes.)

  `copy.mode`

  :   logical: should file permission bits be copied where possible?

  `copy.date`

  :   logical: should file dates be preserved where possible? See
      [`Sys.setFileTime`](https://rdrr.io/r/base/Sys.setFileTime.html).

## Value

No return value, called for side effect.

## See also

Other Report templates and formats:
[`open_schola_template()`](https://scholaempirica.github.io/reschola/reference/open_schola_template.md),
[`schola_pdf()`](https://scholaempirica.github.io/reschola/reference/schola_pdf.md),
[`schola_word()`](https://scholaempirica.github.io/reschola/reference/schola_word.md),
[`schola_word2()`](https://scholaempirica.github.io/reschola/reference/schola_word2.md)

## Author

Jan Netik

## Examples

``` r
if (FALSE) { # \dontrun{
copy_schola_template()
} # }
```
