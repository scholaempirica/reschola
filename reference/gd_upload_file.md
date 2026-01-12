# Upload a file to project's Google Drive

Upload a file to project's Google Drive

## Usage

``` r
gd_upload_file(file, dir = gd_get_proj())
```

## Arguments

- file:

  *character*, path to the file.

- dir:

  Directory at Google Drive, defaults to current reschola project
  directory picked up by
  [`gd_get_proj()`](https://scholaempirica.github.io/reschola/reference/gd_get_proj.md).

## Value

An object of class `dribble`, a tibble with one row per file.
