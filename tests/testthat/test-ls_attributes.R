test_that("ls_get_attrs() returns a named character vector", {
  # I get 403 at GHA (don't know why it stopped working), skip the test there
  skip_on_ci()

  cur_surveys <- ls_surveys()
  attrs <- NULL
  newest_survey_index <- nrow(cur_surveys) + 1L

  # if the newest survey has no attributes, try the next one until success
  while (is.null(attrs)) {
    newest_survey_index <- newest_survey_index - 1L
    sample_survey <- cur_surveys[[newest_survey_index, "survey_id"]]
    attrs <- ls_get_attrs(sample_survey)
  }

  expect_type(attrs, "character")
  expect_named(attrs)
})
