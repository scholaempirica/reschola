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
  response_type = "long",
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

- response_type:

  *character*, either `long` (the default) or `short`. Passed to
  LimeSurvey as `sResponseType`. Since LimeSurvey 7.9.0, the "R-syntax"
  script adds answer labels (factor levels) only with `long`, otherwise
  you get raw answer codes. See
  <https://bugs.limesurvey.org/view.php?id=19889>.

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

  `na_matches`

  :   Should two `NA` or two `NaN` values match?

      - `"na"`, the default, treats two `NA` or two `NaN` values as
        equal, like `%in%`,
        [`match()`](https://rdrr.io/r/base/match.html), and
        [`merge()`](https://rdrr.io/r/base/merge.html).

      - `"never"` treats two `NA` or two `NaN` values as different, and
        will never match them together or to any other values. This is
        similar to joins for database sources and to
        `base::merge(incomparables = NA)`.

  `multiple`

  :   Handling of rows in `x` with multiple matches in `y`. For each row
      of `x`:

      - `"all"`, the default, returns every match detected in `y`. This
        is the same behavior as SQL.

      - `"any"` returns one match detected in `y`, with no guarantees on
        which match will be returned. It is often faster than `"first"`
        and `"last"` if you just need to detect if there is at least one
        match.

      - `"first"` returns the first match detected in `y`.

      - `"last"` returns the last match detected in `y`.

  `unmatched`

  :   How should unmatched keys that would result in dropped rows be
      handled?

      - `"drop"` drops unmatched keys from the result.

      - `"error"` throws an error if unmatched keys are detected.

      `unmatched` is intended to protect you from accidentally dropping
      rows during a join. It only checks for unmatched keys in the input
      that could potentially drop rows.

      - For left joins, it checks `y`.

      - For right joins, it checks `x`.

      - For inner joins, it checks both `x` and `y`. In this case,
        `unmatched` is also allowed to be a character vector of length 2
        to specify the behavior for `x` and `y` independently.

  `relationship`

  :   Handling of the expected relationship between the keys of `x` and
      `y`. If the expectations chosen from the list below are
      invalidated, an error is thrown.

      - `NULL`, the default, doesn't expect there to be any relationship
        between `x` and `y`. However, for equality joins it will check
        for a many-to-many relationship (which is typically unexpected)
        and will warn if one occurs, encouraging you to either take a
        closer look at your inputs or make this relationship explicit by
        specifying `"many-to-many"`.

        See the *Many-to-many relationships* section for more details.

      - `"one-to-one"` expects:

        - Each row in `x` matches at most 1 row in `y`.

        - Each row in `y` matches at most 1 row in `x`.

      - `"one-to-many"` expects:

        - Each row in `y` matches at most 1 row in `x`.

      - `"many-to-one"` expects:

        - Each row in `x` matches at most 1 row in `y`.

      - `"many-to-many"` doesn't perform any relationship checks, but is
        provided to allow you to be explicit about this relationship if
        you know it exists.

      `relationship` doesn't handle cases where there are zero matches.
      For that, see `unmatched`.

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
