# Export Responses with Participants Attached

Export Responses with Participants Attached

## Usage

``` r
ls_export(
  survey_id,
  attributes = TRUE,
  clean_labels = TRUE,
  n_participants = 999,
  lang = "cs",
  part = "all",
  only_unused_tokens = FALSE,
  join_by = "token",
  standardize_dates = TRUE,
  ...
)
```

## Arguments

- survey_id:

  *integer*, ID of the survey (as found with `ls_surveys`, e.g.).

- attributes:

  *logical* try to recover all attributes (default to TRUE), or
  *character vector* specifying requested attributes.

- clean_labels:

  *logical*, whether to clean labels of subquestions from repeating
  parts. Defaults to `TRUE`.

- n_participants:

  *integer*, the number of participants to list, defualt to 999.

- lang:

  *character*, ISO 639 language code, default to `cs`.

- part:

  *character*, completion status, either `complete`, `incomplete` or
  `all` (the default).

- only_unused_tokens:

  *logical*, should only the unused tokens be listed? Default to FALSE.

- join_by:

  *character*, the joining variable present in both responses and
  participants tibbles. Default to `token`. Pass `NULL` to join by
  common variables.

- standardize_dates:

  *logical*, whether to standardize dates to `Date`.

- ...:

  Arguments passed on to
  [`dplyr::left_join`](https://dplyr.tidyverse.org/reference/mutate-joins.html)

  `copy`

  :   If `x` and `y` are not from the same data source, and `copy` is
      `TRUE`, then `y` will be copied into the same src as `x`. This
      allows you to join tables across srcs, but it is a potentially
      expensive operation so you must opt into it.

  `suffix`

  :   If there are non-joined duplicate variables in `x` and `y`, these
      suffixes will be added to the output to disambiguate them. Should
      be a character vector of length 2.

  `keep`

  :   Should the join keys from both `x` and `y` be preserved in the
      output?

      - If `NULL`, the default, joins on equality retain only the keys
        from `x`, while joins on inequality retain the keys from both
        inputs.

      - If `TRUE`, all keys from both inputs are retained.

      - If `FALSE`, only keys from `x` are retained. For right and full
        joins, the data in key columns corresponding to rows that only
        exist in `y` are merged into the key columns from `x`. Can't be
        used when joining on inequality conditions.

## Value

A tibble.

## See also

Other LimeSurvey functions:
[`ls_add_participants()`](https://scholaempirica.github.io/reschola/reference/ls_add_participants.md),
[`ls_call()`](https://scholaempirica.github.io/reschola/reference/ls_call.md),
[`ls_get_attrs()`](https://scholaempirica.github.io/reschola/reference/ls_get_attrs.md),
[`ls_invite()`](https://scholaempirica.github.io/reschola/reference/ls_invite.md),
[`ls_login()`](https://scholaempirica.github.io/reschola/reference/ls_login.md),
[`ls_participants()`](https://scholaempirica.github.io/reschola/reference/ls_participants.md),
[`ls_responses()`](https://scholaempirica.github.io/reschola/reference/ls_responses.md),
[`ls_set_participant_properties()`](https://scholaempirica.github.io/reschola/reference/ls_set_participant_properties.md),
[`ls_surveys()`](https://scholaempirica.github.io/reschola/reference/ls_surveys.md)

## Examples

``` r
if (FALSE) { # \dontrun{
ls_export(123456)
} # }
```
