# Add or replace logo in the header of a Word document

Takes an existing Word document created using the `reschola` templates
and adds (by default, or replaces if `action = "replace_schola"`) the
logo with the image file you point it to.

## Usage

``` r
manage_docx_header_logos(
  docx_path,
  png_logo_path,
  action = c("add_client", "replace_schola"),
  height = NULL
)
```

## Arguments

- docx_path:

  The Word document in which to replace logos. Must contain the
  bookmarks `schola_logo` and `client_logo` in the header (files created
  from reschola templates do by default.)

- png_logo_path:

  a PNG file which will be added/used as replacement

- action:

  whether to add new logo on the right (`"add_client"`) or replace
  default Schola logo on the left (`"replace_schola"`)

- height:

  height of the new logo in the resulting document, in `cm`. By default,
  uses the height of the existing Schola logo in the header.

## Value

invisibly returns the name of the new Word doc, which is same as the
input Word doc, with an an added `_addedlogo` suffix.

## Note

This requires specific bookmarks in the header of the input document.
This is taken from the skeleton.docx template in the template
components. If you overwrite the header in the input document, this
function will not work.

## See also

Other Workflow helpers:
[`draft_pdf()`](https://scholaempirica.github.io/reschola/reference/draft.md),
[`gd_download_folder()`](https://scholaempirica.github.io/reschola/reference/gd_download_folder.md)

## Examples

``` r
if (FALSE) { # \dontrun{
library(reschola)
manage_docx_header_logos("draft.docx",
  png_logo_path = "logos/newlogo.png",
  action = "add_client"
)
manage_docx_header_logos("draft.docx",
  png_logo_path = "logos/newlogo.png",
  action = "replace_schola"
)
} # }
```
