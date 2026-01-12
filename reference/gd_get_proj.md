# Get current reschola project Google Drive URL ID

Gets a hidden object `.gd_proj_url` (by default) created at project
"startup". See the details below for reschola projects created prior
reschola version 0.4.0.

## Usage

``` r
gd_get_proj(url_object = ".gd_proj_url")
```

## Arguments

- url_object:

  *character*, name of the object URL is stored in. `.gd_proj_url` by
  default.

## Value

A character vector of class `drive_id`.

## Legacy usage prior to {reschola} version 0.4.0

Call `usethis::edit_r_profile(scope = "project")` and write (note the
dot prefix):

    .gd_proj_url <- "your_google_drive_url"

Note that **you have to restart your R session to apply any changes**.
Note also that **the URL cannot contain any query** (parts with a
leading question mark), i.e. `?usp=sharing`.
