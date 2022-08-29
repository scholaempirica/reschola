test_that("ls_get_attrs() returns a named character vector", {
  cur_surveys <- ls_surveys()
  sample_survey <- cur_surveys[[nrow(cur_surveys), "survey_id"]]
  attrs <- ls_get_attrs(sample_survey)

  expect_type(attrs, "character")
  expect_named(attrs)
})
