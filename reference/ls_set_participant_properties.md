# Set or Edit Attribute(s) of an Participant

Set or Edit Attribute(s) of an Participant

## Usage

``` r
ls_set_participant_properties(survey_id, participant, ...)
```

## Arguments

- survey_id:

  *integer*, ID of the survey (as found with
  [`ls_surveys()`](https://scholaempirica.github.io/reschola/reference/ls_surveys.md),
  e.g.).

- participant:

  *integer* or *list*, **one** token ID (**not token!**) from
  participant database. Use
  [`ls_participants()`](https://scholaempirica.github.io/reschola/reference/ls_participants.md)
  to get the `tid`. Another option is to pass a list of one ore more
  participant properties, i.e. `list(lastname = "Doe")`

- ...:

  attributes in the form `attribute_name = attribute_value`.

## Value

A tibble with the participant row just edited.

## See also

Other LimeSurvey functions:
[`ls_add_participants()`](https://scholaempirica.github.io/reschola/reference/ls_add_participants.md),
[`ls_call()`](https://scholaempirica.github.io/reschola/reference/ls_call.md),
[`ls_export()`](https://scholaempirica.github.io/reschola/reference/ls_export.md),
[`ls_get_attrs()`](https://scholaempirica.github.io/reschola/reference/ls_get_attrs.md),
[`ls_invite()`](https://scholaempirica.github.io/reschola/reference/ls_invite.md),
[`ls_login()`](https://scholaempirica.github.io/reschola/reference/ls_login.md),
[`ls_participants()`](https://scholaempirica.github.io/reschola/reference/ls_participants.md),
[`ls_responses()`](https://scholaempirica.github.io/reschola/reference/ls_responses.md),
[`ls_surveys()`](https://scholaempirica.github.io/reschola/reference/ls_surveys.md)

## Examples

``` r
if (FALSE) { # \dontrun{
ls_set_participant_properties(123456,
  participant = 18, email = "new@email.cz",
  attribute_1 = 600123456
)
} # }
```
