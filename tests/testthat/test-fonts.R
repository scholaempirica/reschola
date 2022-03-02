test_that("fonts register on Windows", {
  skip_on_os(c("mac", "linux", "solaris"))

  expect_true(register_reschola_fonts())
  expect_message(register_reschola_fonts(), "[R|r]egistering fonts")
  expect_invisible(register_reschola_fonts())
  expect_true(all(c("Ubuntu", "Ubuntu Condensed") %in% windowsFonts()))
})

test_that("font registration skips on Unix", {
  skip_on_os("windows")
  expect_false(register_reschola_fonts())
  expect_invisible(register_reschola_fonts())
})
