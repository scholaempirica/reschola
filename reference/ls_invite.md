# Invite Participant(s)

Send an email with a link to a survey to the particular participant(s).
Uses email template specified in the LimeSurvey web interface. Please
read the section *"On errors and messages from the API server"* of this
documentation page before use.

## Usage

``` r
ls_invite(survey_id, tid, uninvited_only = TRUE)
```

## Arguments

- survey_id:

  *integer*, ID of the survey (as found with
  [`ls_surveys()`](https://scholaempirica.github.io/reschola/reference/ls_surveys.md),
  e.g.).

- tid:

  *integer(s)*, one ore more token IDs (**not tokens!**) from
  participant database to invite. Use
  [`ls_participants()`](https://scholaempirica.github.io/reschola/reference/ls_participants.md)
  to get the `tid`s.

- uninvited_only:

  *logical*, if `TRUE`, send invitation for participants that have not
  been invited yet (default). If `FALSE`, send an invite even if already
  sent.

## Value

Called for a side effect. Returns a message from the server.

## Details

LimeSurvey allows you to send so-called invitation to a participant,
meaning he or she will get an email containing a link with his or her
unique access token. If you wish to send the invitation even if it has
been already sent, use `uninvited_only = FALSE`.

## On errors and messages from the API server

Note that the function passes on any messages from the LimeSurvey API
server. As usual with LimeSurvey, many things are erroneous, buggy or
does not make sense. In this case, a sign of a successful invitation is
something like *"-1 left to send"* (where *"-1"* denotes the number of
invitations sent).

Another message you may see is *"Error: No candidate tokens"*, which
possibly means that the `tid`s you use are not present in the survey of
concern. However, it can also indicate that the invitation has been
already sent to the `tid`s and you have to use `uninvited_only = FALSE`
to proceed.

**Note that when you add an email entry that has not a proper email
format, no participants are added and tibble with `errors$email`
list-column is returned.**

## See also

Other LimeSurvey functions:
[`ls_add_participants()`](https://scholaempirica.github.io/reschola/reference/ls_add_participants.md),
[`ls_call()`](https://scholaempirica.github.io/reschola/reference/ls_call.md),
[`ls_export()`](https://scholaempirica.github.io/reschola/reference/ls_export.md),
[`ls_get_attrs()`](https://scholaempirica.github.io/reschola/reference/ls_get_attrs.md),
[`ls_login()`](https://scholaempirica.github.io/reschola/reference/ls_login.md),
[`ls_participants()`](https://scholaempirica.github.io/reschola/reference/ls_participants.md),
[`ls_responses()`](https://scholaempirica.github.io/reschola/reference/ls_responses.md),
[`ls_set_participant_properties()`](https://scholaempirica.github.io/reschola/reference/ls_set_participant_properties.md),
[`ls_surveys()`](https://scholaempirica.github.io/reschola/reference/ls_surveys.md)

## Examples

``` r
if (FALSE) { # \dontrun{
ls_invite(123456, 18)
} # }
```
