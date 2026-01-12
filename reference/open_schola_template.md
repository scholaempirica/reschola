# Locate and open default Schola templates

Open the default Schola templates used by
[`schola_word()`](https://scholaempirica.github.io/reschola/reference/schola_word.md),
or
[`schola_pdf()`](https://scholaempirica.github.io/reschola/reference/schola_pdf.md)
(specify with `format` argument). The templates are shipped with the
package and are somewhat hidden in `R` library, so this auxiliary
function can help you dig them up.

## Usage

``` r
open_schola_template(format = "pdf")
```

## Arguments

- format:

  *Character*, format which to look for. Defaults to `pdf`.

## Value

No return value, called for side effect.

## Details

You can either edit the chosen template directly in its natural habitat
(questionable short-term solution), or better – use "Save as" option and
keep it and use it within the project directory.

## See also

Other Report templates and formats:
[`copy_schola_template()`](https://scholaempirica.github.io/reschola/reference/copy_schola_template.md),
[`schola_pdf()`](https://scholaempirica.github.io/reschola/reference/schola_pdf.md),
[`schola_word()`](https://scholaempirica.github.io/reschola/reference/schola_word.md),
[`schola_word2()`](https://scholaempirica.github.io/reschola/reference/schola_word2.md)

## Author

Jan Netik

## Examples

``` r
if (FALSE) { # \dontrun{
open_schola_template()
} # }
```
