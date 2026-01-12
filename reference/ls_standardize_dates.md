# Standardize Date Variables in LimeSurvey Data

Standardize Date Variables in LimeSurvey Data

## Usage

``` r
ls_standardize_dates(
  .data,
  date_cols = c("completed", "sent", "submitdate", "startdate", "datestamp"),
  as_na = c("", "N", "Y"),
  ...
)
```

## Arguments

- .data:

  *tibble*, data frame with LimeSurvey data.

- date_cols:

  *character*, names of date columns to be standardized.

- as_na:

  *character*, values to be coerced to `NA` (default to
  `c("", "N", "Y")`).

- ...:

  Arguments passed on to
  [`lubridate::parse_date_time`](https://lubridate.tidyverse.org/reference/parse_date_time.html)

  `orders`

  :   a character vector of date-time formats. Each order string is a
      series of formatting characters as listed in
      [`base::strptime()`](https://rdrr.io/r/base/strptime.html) but
      might not include the `"%"` prefix. For example, "ymd" will match
      all the possible dates in year, month, day order. Formatting
      orders might include arbitrary separators. These are discarded.
      See details for the implemented formats. If multiple order strings
      are supplied, they are applied in turn for `parse_date_time2()`
      and `fast_strptime()`. For `parse_date_time()` the order of
      applied formats is determined by `select_formats` parameter.

  `tz`

  :   a character string that specifies the time zone with which to
      parse the dates

  `truncated`

  :   integer, number of formats that can be missing. The most common
      type of irregularity in date-time data is the truncation due to
      rounding or unavailability of the time stamp. If the `truncated`
      parameter is non-zero `parse_date_time()` also checks for
      truncated formats. For example, if the format order is "ymdHMS"
      and `truncated = 3`, `parse_date_time()` will correctly parse
      incomplete date-times like `2012-06-01 12:23`, `2012-06-01 12` and
      `2012-06-01`. **NOTE:** The `ymd()` family of functions is based
      on [`base::strptime()`](https://rdrr.io/r/base/strptime.html)
      which currently fails to parse `%Y-%m` formats.

  `quiet`

  :   logical. If `TRUE`, progress messages are not printed, and
      `No formats found` error is suppressed and the function simply
      returns a vector of NAs. This mirrors the behavior of base R
      functions
      [`base::strptime()`](https://rdrr.io/r/base/strptime.html) and
      [`base::as.POSIXct()`](https://rdrr.io/r/base/as.POSIXlt.html).

  `locale`

  :   locale to be used, see
      [locales](https://rdrr.io/r/base/locales.html). On Linux systems
      you can use `system("locale -a")` to list all the installed
      locales.

  `select_formats`

  :   A function to select actual formats for parsing from a set of
      formats which matched a training subset of `x`. It receives a
      named integer vector and returns a character vector of selected
      formats. Names of the input vector are formats (not orders) that
      matched the training set. Numeric values are the number of dates
      (in the training set) that matched the corresponding format. You
      should use this argument if the default selection method fails to
      select the formats in the right order. By default the formats with
      most formatting tokens (`%`) are selected and `%Y` counts as 2.5
      tokens (so that it has a priority over `%y%m`). See examples.

  `exact`

  :   logical. If `TRUE`, the `orders` parameter is interpreted as an
      exact [`base::strptime()`](https://rdrr.io/r/base/strptime.html)
      format and no training or guessing are performed (i.e. `train`,
      `drop` parameters are ignored).

  `train`

  :   logical, default `TRUE`. Whether to train formats on a subset of
      the input vector. As a result the supplied orders are sorted
      according to performance on this training set, which commonly
      results in increased performance. Please note that even when
      `train = FALSE` (and `exact = FALSE`) guessing of the actual
      formats is still performed on the training set (a pseudo-random
      subset of the original input vector). This might result in
      `All formats failed to parse` error. See notes below.

  `drop`

  :   logical, default `FALSE`. Whether to drop formats that didn't
      match on the training set. If `FALSE`, unmatched on the training
      set formats are tried as a last resort at the end of the parsing
      queue. Applies only when `train = TRUE`. Setting this parameter to
      `TRUE` might slightly speed up parsing in situations involving
      many formats. Prior to v1.7.0 this parameter was implicitly
      `TRUE`, which resulted in occasional surprising behavior when rare
      patterns where not present in the training set.

## Value

A tibble with standardized date variables.
