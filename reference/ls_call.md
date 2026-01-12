# Call LimeSurvey API Directly

General function used internally by every other `ls_` fellow. Useful
when you want something special that is not (yet) implemented in
`reschola`.

## Usage

``` r
ls_call(method, params = list())
```

## Arguments

- method:

  *character*, a method supported by LimeSurvey API.

- params:

  *list*, arguments of the method. Need to be in order stated in
  documentation. **Note that `sSessionKey` auth credentials are already
  provided as the first entry of `params` list.**

## Value

A tibble, or raw object if server response cannot be reasonably coerced
to a tibble.

## Details

[The list of available LimeSurvey API
calls](https://api.limesurvey.org/classes/remotecontrol_handle.html)
briefly documents the functionality provided. You must strictly adhere
to the arguments positions, as they are passed as an array.

## See also

Other LimeSurvey functions:
[`ls_add_participants()`](https://scholaempirica.github.io/reschola/reference/ls_add_participants.md),
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
ls_call("get_survey_properties", params = list(iSurveyID = 123456))
} # }
```
