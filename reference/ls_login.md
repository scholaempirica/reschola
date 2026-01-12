# Login to LimeSurvey API

Obtains XML-RPC/JSON-RPC session key and stores it in dedicated
environment for further use by fellow `ls_` functions.

## Usage

``` r
ls_login(
  api_url =
    "https://dotazniky.scholaempirica.org/limesurvey/index.php/admin/remotecontrol"
)
```

## Arguments

- api_url:

  *character*, URL of the API endpoint, default to SCHOLA EMPIRICA's
  LimeSurvey API.

## Value

No "explicit" return value, but assigns the session key to a dedicated
environment.

## Details

By default, <https://dotazniky.scholaempirica.org/> is used as the
LimeSurvey server prividing the API. The credentials used for user
authentication are obtained through interactive prompts, mainly for
security reasons. The function tries to obtain the credentials from the
system environment variable table first. If none found, the user is
asked for them and is provided with guidance for permanent credential
storage.

## See also

Other LimeSurvey functions:
[`ls_add_participants()`](https://scholaempirica.github.io/reschola/reference/ls_add_participants.md),
[`ls_call()`](https://scholaempirica.github.io/reschola/reference/ls_call.md),
[`ls_export()`](https://scholaempirica.github.io/reschola/reference/ls_export.md),
[`ls_get_attrs()`](https://scholaempirica.github.io/reschola/reference/ls_get_attrs.md),
[`ls_invite()`](https://scholaempirica.github.io/reschola/reference/ls_invite.md),
[`ls_participants()`](https://scholaempirica.github.io/reschola/reference/ls_participants.md),
[`ls_responses()`](https://scholaempirica.github.io/reschola/reference/ls_responses.md),
[`ls_set_participant_properties()`](https://scholaempirica.github.io/reschola/reference/ls_set_participant_properties.md),
[`ls_surveys()`](https://scholaempirica.github.io/reschola/reference/ls_surveys.md)

## Examples

``` r
if (FALSE) { # \dontrun{
ls_login()
} # }
```
