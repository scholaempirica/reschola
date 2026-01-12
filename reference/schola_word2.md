# Schola Empirica Word document with customisable template

**\[deprecated\]**

This is a function called in the output part of the YAML section of the
Rmd file while using the Word template provided at the same place (see
example below).

## Usage

``` r
schola_word2(...)
```

## Arguments

- ...:

  Arguments to be passed to `[bookdown::word_document2]`

## Value

A modified `word_document2` with the standard Schola formatting, but
without hard-coded and unchangeable template.

## Details

Compared to `schola_word`, this "version" comes with no predefined
template, so the user can utilize a template stated in YAML header (see
the example below, or read the [`bookdown`
manual](https://bookdown.org/yihui/rmarkdown-cookbook/word-template.html)
for more details and for a brief guide to Word templating).

## See also

Other Report templates and formats:
[`copy_schola_template()`](https://scholaempirica.github.io/reschola/reference/copy_schola_template.md),
[`open_schola_template()`](https://scholaempirica.github.io/reschola/reference/open_schola_template.md),
[`schola_pdf()`](https://scholaempirica.github.io/reschola/reference/schola_pdf.md),
[`schola_word()`](https://scholaempirica.github.io/reschola/reference/schola_word.md)

## Author

Jan Netik

## Examples

``` r
if (FALSE) { # \dontrun{
output:
reschola::schola_word2:
reference_docx:template.docx
} # }
```
