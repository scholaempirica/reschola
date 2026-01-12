# Basic Schola Empirica Word document

This is a function called in the output of the YAML of the Rmd file to
specify using the standard Schola word document formatting.

## Usage

``` r
schola_word(
  reference_docx = find_resource("schola_word", "template.docx"),
  ...
)
```

## Arguments

- reference_docx:

  Path to custom template. By default, the built-in one is used.

- ...:

  Arguments passed on to
  [`bookdown::word_document2`](https://pkgs.rstudio.com/bookdown/reference/html_document2.html)

  :   

## Value

A modified `word_document2` with the standard Schola formatting.

## Details

If no template is specified, the function will use the `reschola`'s
default template. Path to template is relative to document being
compiled. See the examples below, or read the [`bookdown`
manual](https://bookdown.org/yihui/rmarkdown-cookbook/word-template.html)
for more details and for a brief guide to Word templating).

## See also

Other Report templates and formats:
[`copy_schola_template()`](https://scholaempirica.github.io/reschola/reference/copy_schola_template.md),
[`open_schola_template()`](https://scholaempirica.github.io/reschola/reference/open_schola_template.md),
[`schola_pdf()`](https://scholaempirica.github.io/reschola/reference/schola_pdf.md),
[`schola_word2()`](https://scholaempirica.github.io/reschola/reference/schola_word2.md)

## Author

Petr Bouchal

Jan Netik

## Examples

``` r
if (FALSE) { # \dontrun{
#  # with the default template
output:
reschola::schola_word

# with a user-specified template
output:
reschola::schola_word:
reference_docx:template.docx
} # }
```
