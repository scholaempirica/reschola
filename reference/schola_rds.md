# Quick access to data in standard `reschola` project

Note that file paths are handled with `here()` already.

## Usage

``` r
get_input_data(file)

get_intermediate_data(file)

get_processed_data(file)

write_input_data(.data, file)

write_intermediate_data(.data, file)

write_processed_data(.data, file)
```

## Arguments

- file:

  *character*, file name to get or write to, `.rds` is appended
  automatically if not already provided.

- .data:

  *data object* to save as RDS.

## Value

- `get_*` returns object(s) in the `.rds` being read

- `write_*` returns a `fs_path` path of `.rds` file being created
  invisibly
