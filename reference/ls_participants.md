# List Participants

Fetches participant list of the solicited survey. The function tries to
retrieve as many attributes as possible and translate them to their
"semantic" version by default. You can also provide character vector of
requested attributes, but not in the "semantic" form (use, e.g.,
`attribute_1` or `usesleft`).

## Usage

``` r
ls_participants(
  survey_id,
  attributes = TRUE,
  n_participants = 999,
  only_unused_tokens = FALSE,
  translate_attrs = TRUE,
  standardize_dates = TRUE
)
```

## Arguments

- survey_id:

  *integer*, ID of the survey (as found, e.g., with
  [`ls_surveys()`](https://scholaempirica.github.io/reschola/reference/ls_surveys.md)).

- attributes:

  *logical* try to recover all attributes (default to TRUE), or
  *character vector* specifying requested attributes.

- n_participants:

  *integer*, the number of participants to list, defualt to 999.

- only_unused_tokens:

  *logical*, should only the unused tokens be listed? Default to FALSE.

- translate_attrs:

  *logical*, should the custom attributes be "translated" to "semantic"
  version? Default to TRUE.

- standardize_dates:

  *logical*, whether to standardize dates to `Date`.

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
[`ls_responses()`](https://scholaempirica.github.io/reschola/reference/ls_responses.md),
[`ls_set_participant_properties()`](https://scholaempirica.github.io/reschola/reference/ls_set_participant_properties.md),
[`ls_surveys()`](https://scholaempirica.github.io/reschola/reference/ls_surveys.md)

## Examples

``` r
if (FALSE) { # \dontrun{
ls_participants(123456, attributes = c("usesleft"))
} # }
```
