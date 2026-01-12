# Add Participant(s) to the Survey

The function takes a `tibble` (or any object that is internally
represented as a (named) `list` by `R`) of participant(s) data and adds
them to the LimeSurvey participant database of the selected survey.

## Usage

``` r
ls_add_participants(survey_id, part_data, create_token = TRUE)
```

## Arguments

- survey_id:

  *integer*, ID of the survey (as found with `ls_surveys`, e.g.).

- part_data:

  *tibble / data.frame / list*, object with participant(s) data, i.e.,
  `firstname`, `lastname`, `email` etc.

- create_token:

  *logical*, whether to create token outright. Defaults to `TRUE`).

## Value

Called for a side effect, but returns the inserted data including
additional new information like the token string.

## Details

Generally, your `part_data` object have to contain three variables:
`firstname`, `lastname`, and `email`. That is something like a bare
minimum, but you may add any attribute recognized by LimeSurvey – even
custom attributes like `attribute_1` or so. For the human-readable list
of custom attributes being held in the LimeSurvey participant database
of the selected survey, use
[`ls_get_attrs()`](https://scholaempirica.github.io/reschola/reference/ls_get_attrs.md).
However, do not use the "semantic" form, as `ls_add_participants()`
recognizes only raw, i.e. `attribute_1` notation.

## See also

Other LimeSurvey functions:
[`ls_call()`](https://scholaempirica.github.io/reschola/reference/ls_call.md),
[`ls_export()`](https://scholaempirica.github.io/reschola/reference/ls_export.md),
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
# create participant table
part_data <- tibble(
  firstname = "John",
  lastname = "Doe",
  email = "john@example.com",
  language = "cs",
  attribute_1 = "Example School"
)

# insert participant into the LimeSurvey database
ls_add_participants(123456, part_data)

# check if OK
ls_participants(123456)
} # }
```
