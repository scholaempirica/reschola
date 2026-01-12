# Export Responses

Fetches responses and applies so-called "R-syntax" transformation script
from LimeSurvey pertaining factor levels and items labels (those are
readily available in RStudio data frame preview and can be extracted
using `attr(.data, "label")`). By default, the function attempts to
"clean" the labels (`clean_labels` argument), keeping only the content
inside `[...]`, if there are any.

## Usage

``` r
ls_responses(
  survey_id,
  clean_labels = TRUE,
  lang = "cs",
  part = "all",
  standardize_dates = TRUE,
  ...
)
```

## Arguments

- survey_id:

  *integer*, ID of the survey (as found with `ls_surveys`, e.g.).

- clean_labels:

  *logical*, whether to clean labels of subquestions from repeating
  parts. Defaults to `TRUE`.

- lang:

  *character*, ISO 639 language code, default to `cs`.

- part:

  *character*, completion status, either `complete`, `incomplete` or
  `all` (the default).

- standardize_dates:

  *logical*, whether to standardize dates to `Date`.

- ...:

  *other named arguments* used by "export_responses" method. Use at your
  own risk.

## Value

A tibble, or raw object if server response cannot be reasonably coerced
to a tibble.

## See also

Other LimeSurvey functions:
[`ls_add_participants()`](https://scholaempirica.github.io/reschola/reference/ls_add_participants.md),
[`ls_call()`](https://scholaempirica.github.io/reschola/reference/ls_call.md),
[`ls_export()`](https://scholaempirica.github.io/reschola/reference/ls_export.md),
[`ls_get_attrs()`](https://scholaempirica.github.io/reschola/reference/ls_get_attrs.md),
[`ls_invite()`](https://scholaempirica.github.io/reschola/reference/ls_invite.md),
[`ls_login()`](https://scholaempirica.github.io/reschola/reference/ls_login.md),
[`ls_participants()`](https://scholaempirica.github.io/reschola/reference/ls_participants.md),
[`ls_set_participant_properties()`](https://scholaempirica.github.io/reschola/reference/ls_set_participant_properties.md),
[`ls_surveys()`](https://scholaempirica.github.io/reschola/reference/ls_surveys.md)

## Examples

``` r
if (FALSE) { # \dontrun{
ls_responses(123456)
} # }
```
