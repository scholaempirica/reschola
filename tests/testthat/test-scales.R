test_that("Czech scales label numbers with decimal comma and space separator", {
  expect_equal(scale_x_percent_cz()$labels(c(0.5, 0.123)), c("50 %", "12 %"))
  expect_equal(
    scale_y_percent_cz(accuracy = 0.1)$labels(0.1234),
    "12,3 %"
  )
  expect_equal(scale_x_number_cz()$labels(1234567), "1 234 567")
  expect_equal(scale_y_number_cz(accuracy = 0.1)$labels(1234.56), "1 234,6")
})

test_that("English scales label numbers with decimal point", {
  expect_equal(scale_x_percent()$labels(c(0.5, 0.123)), c("50%", "12%"))
  expect_equal(scale_y_percent(accuracy = 0.1)$labels(0.1234), "12.3%")
  expect_equal(scale_x_comma()$labels(1234567), "1,234,567")
  expect_equal(scale_y_comma(accuracy = 0.1)$labels(1234.56), "1,234.6")
})

test_that("scales are x or y position scales with the expected defaults", {
  x_scales <- list(
    scale_x_percent_cz(),
    scale_x_number_cz(),
    scale_x_percent(),
    scale_x_comma()
  )
  y_scales <- list(
    scale_y_percent_cz(),
    scale_y_number_cz(),
    scale_y_percent(),
    scale_y_comma()
  )

  for (sc in x_scales) {
    expect_s3_class(sc, "ScaleContinuousPosition")
    expect_true("x" %in% sc$aesthetics)
    expect_equal(sc$position, "bottom")
    expect_equal(sc$expand, c(0.01, 0))
  }
  for (sc in y_scales) {
    expect_s3_class(sc, "ScaleContinuousPosition")
    expect_true("y" %in% sc$aesthetics)
    expect_equal(sc$position, "left")
    expect_equal(sc$expand, c(0.01, 0))
  }

  for (sc in c(x_scales, y_scales)) {
    expect_null(sc$limits)
  }
})

test_that("labels can be overridden", {
  expect_null(scale_x_percent_cz(labels = NULL)$labels)
  expect_equal(
    scale_y_comma(labels = label_number_cz())$labels(1234.5),
    "1 234"
  )
})

test_that("other arguments are passed on to the ggplot2 scale", {
  sc <- scale_x_number_cz(
    breaks = c(1, 2),
    sec.axis = ggplot2::dup_axis()
  )
  expect_equal(sc$breaks, c(1, 2))
  expect_s3_class(sc$secondary.axis, "AxisSecondary")

  expect_equal(scale_y_comma(position = "right")$position, "right")
})

test_that("scales work in a built plot", {
  p <- ggplot2::ggplot(
    data.frame(x = c(1000, 2500), y = c(0.25, 0.5)),
    ggplot2::aes(x, y)
  ) +
    ggplot2::geom_point() +
    scale_x_number_cz() +
    scale_y_percent_cz()

  expect_no_error(ggplot2::ggplot_build(p))
})
