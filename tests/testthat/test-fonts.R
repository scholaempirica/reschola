test_that("font registration respect platform", {
  expect_invisible(register_reschola_fonts())

  if (.Platform$OS.type == "windows") {
    expect_equal(register_reschola_fonts(), TRUE)
    expect_message(register_reschola_fonts(), "Registering fonts")
  }

  if (.Platform$OS.type != "windows") {
    expect_equal(register_reschola_fonts(), FALSE)
  }
})
