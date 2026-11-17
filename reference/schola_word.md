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

  `number_sections`

  :   Whether to number section headers: if `TRUE`, figure/table numbers
      will be of the form `X.i`, where `X` is the current first-level
      section number, and `i` is an incremental number (the i-th
      figure/table); if `FALSE`, figures/tables will be numbered
      sequentially in the document from 1, 2, ..., and you cannot
      cross-reference section headers in this case.

  `global_numbering`

  :   If `TRUE`, number figures and tables globally throughout a
      document (e.g., Figure 1, Figure 2, ...). If `FALSE`, number them
      sequentially within sections (e.g., Figure 1.1, Figure 1.2, ...,
      Figure 5.1, Figure 5.2, ...). Note that `global_numbering = FALSE`
      will not work with `number_sections = FALSE` because sections are
      not numbered.

  `base_format`

  :   An output format function to be used as the base format.

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
