# Download files from Google Drive folder

Downloads all downloadable files from given Google Drive folder and
saves them to specified local directory. Files will have the same names.
Use
[`googledrive::drive_download()`](https://googledrive.tidyverse.org/reference/drive_download.html)
for downloading individual files.

## Usage

``` r
gd_download_folder(
  folder_url = gd_get_proj(),
  dest_dir = "data/input",
  files_from_subfolders = FALSE,
  overwrite = TRUE
)
```

## Arguments

- folder_url:

  Folder URL.

- dest_dir:

  Local URL in which to store files.

- files_from_subfolders:

  Whether to download also files from subdirectories. Defaults to
  `TRUE`. See Note.

- overwrite:

  Whether to overwrite if file of same name exists.

## Value

vector of paths to downloaded files

## Note

As it would be very difficult to mirror the folder exactly, if
`files_from_subfolders` is set to `TRUE`, files from subfolders will be
saved in the same directory, not in the respective subdirectories. Bear
this in mind when naming files in GDrive subfolders so as to avoid
naming conflicts.

## See also

Other Workflow helpers:
[`draft_pdf()`](https://scholaempirica.github.io/reschola/reference/draft.md),
[`manage_docx_header_logos()`](https://scholaempirica.github.io/reschola/reference/manage_docx_header_logos.md)

## Examples

``` r
if (FALSE) { # \dontrun{
gd_url <- "https://drive.google.com/drive/folders/1bCyR_VKAP_43NEujqisjN77hANnMKfHZ"
gd_download_folder(
  folder_url = gd_url,
  files_from_subfolders = T, overwrite = T
)
} # }
```
