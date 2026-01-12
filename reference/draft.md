# Create a `.Rmd` draft using Schola templates

Shortcut function to create a new `.Rmd` file using Schola standard
templates and open it for editing.

## Usage

``` r
draft_pdf(name = "pdf_draft", open = TRUE)

draft_word(name = "word_draft", open = TRUE)
```

## Arguments

- name:

  *character*, name to use for new file. With or without file extension.

- open:

  *logical*, whether to open file for editing, defaults to TRUE.

## Value

Path to the created file (invisibly).

## See also

Other Workflow helpers:
[`gd_download_folder()`](https://scholaempirica.github.io/reschola/reference/gd_download_folder.md),
[`manage_docx_header_logos()`](https://scholaempirica.github.io/reschola/reference/manage_docx_header_logos.md)

## Examples

``` r
if (FALSE) { # \dontrun{
draft_pdf("best_report")
} # }
```
