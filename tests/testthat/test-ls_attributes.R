test_that("ls_get_attrs() returns a named character vector", {
  cur_surveys <- ls_surveys()
  sample_survey <- sample(cur_surveys$survey_id, 1L)
  attrs <- ls_get_attrs(sample_survey)

  expect_type(attrs, "character")
  expect_named(attrs)
})
