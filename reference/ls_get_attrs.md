# Get Survey Attributes in Semantic Form

A survey can comprise one or more custom attributes useful for encoding
participant characteristics directly within participants table. However,
LimeSurvey refers to them as `attribute_x` (where `x` is the attribute
position) which is not useful at all. The function aims to resolve this
issue by returning so-called "semantic" form of attributes with
human-readable description.

## Usage

``` r
ls_get_attrs(survey_id)
```

## Arguments

- survey_id:

  *integer*, ID of the survey (as found, e.g., with
  [`ls_surveys()`](https://scholaempirica.github.io/reschola/reference/ls_surveys.md)).

## Value

A character vector of "semantic" attributes with names denoting "raw"
attributes used internally by LimeSurvey.

## See also

Other LimeSurvey functions:
[`ls_add_participants()`](https://scholaempirica.github.io/reschola/reference/ls_add_participants.md),
[`ls_call()`](https://scholaempirica.github.io/reschola/reference/ls_call.md),
[`ls_export()`](https://scholaempirica.github.io/reschola/reference/ls_export.md),
[`ls_invite()`](https://scholaempirica.github.io/reschola/reference/ls_invite.md),
[`ls_login()`](https://scholaempirica.github.io/reschola/reference/ls_login.md),
[`ls_participants()`](https://scholaempirica.github.io/reschola/reference/ls_participants.md),
[`ls_responses()`](https://scholaempirica.github.io/reschola/reference/ls_responses.md),
[`ls_set_participant_properties()`](https://scholaempirica.github.io/reschola/reference/ls_set_participant_properties.md),
[`ls_surveys()`](https://scholaempirica.github.io/reschola/reference/ls_surveys.md)

## Examples

``` r
if (FALSE) { # \dontrun{
ls_get_attrs(123456)
} # }
```
