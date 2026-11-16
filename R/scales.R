# nolint start: object_name_linter

# Build a numeric labelling function from the label arguments shared by all
# the position scales below.
scale_number_labels <- function(
  accuracy,
  scale,
  prefix,
  suffix,
  big.mark,
  decimal.mark,
  trim
) {
  scales::label_number(
    accuracy = accuracy,
    scale = scale,
    prefix = prefix,
    suffix = suffix,
    big.mark = big.mark,
    decimal.mark = decimal.mark,
    trim = trim
  )
}


#' Continuous position scales with Czech number and percent labels
#'
#' These are [ggplot2::scale_x_continuous()] and
#' [ggplot2::scale_y_continuous()] with Czech label defaults (decimal comma,
#' space as the thousands separator, `" %"` suffix for percentages), so you
#' don't have to set them repeatedly. The arguments you would normally pass to
#' a `scales::label_*()` function are available directly.
#'
#' @inheritParams ggplot2::scale_x_continuous
#' @inheritParams scales::label_number
#' @param labels Overrides the default labels built from `accuracy`, `scale`,
#'   `prefix`, `suffix`, `big.mark`, `decimal.mark` and `trim`. Accepts
#'   anything [ggplot2::scale_x_continuous()] does, e.g. `NULL` for no labels
#'   or a labelling function such as [label_number_cz()].
#' @param ... Other arguments passed on to [ggplot2::scale_x_continuous()] or
#'   [ggplot2::scale_y_continuous()], e.g. `breaks`, `n.breaks`, `transform`
#'   or `sec.axis`.
#'
#' @return A ggplot2 scale.
#' @export
#' @name scalescz
#' @examples
#' library(reschola)
#' library(ggplot2)
#' ggplot(mpg, aes(hwy * 100, cty / max(cty))) +
#'   geom_point() +
#'   theme_schola(family = "sans", title_family = "sans", gridlines = "scatter") +
#'   scale_y_percent_cz() +
#'   scale_x_number_cz()
scale_x_percent_cz <- function(
  name = waiver(),
  ...,
  labels,
  limits = NULL,
  expand = c(0.01, 0),
  oob = scales::censor,
  position = "bottom",
  accuracy = 1,
  scale = 100,
  prefix = "",
  suffix = " %",
  big.mark = " ",
  decimal.mark = ",",
  trim = TRUE
) {
  if (missing(labels)) {
    labels <- scale_number_labels(
      accuracy,
      scale,
      prefix,
      suffix,
      big.mark,
      decimal.mark,
      trim
    )
  }

  ggplot2::scale_x_continuous(
    name = name,
    ...,
    labels = labels,
    limits = limits,
    expand = expand,
    oob = oob,
    position = position
  )
}


#' @rdname scalescz
#' @export
scale_y_percent_cz <- function(
  name = waiver(),
  ...,
  labels,
  limits = NULL,
  expand = c(0.01, 0),
  oob = scales::censor,
  position = "left",
  accuracy = 1,
  scale = 100,
  prefix = "",
  suffix = " %",
  big.mark = " ",
  decimal.mark = ",",
  trim = TRUE
) {
  if (missing(labels)) {
    labels <- scale_number_labels(
      accuracy,
      scale,
      prefix,
      suffix,
      big.mark,
      decimal.mark,
      trim
    )
  }

  ggplot2::scale_y_continuous(
    name = name,
    ...,
    labels = labels,
    limits = limits,
    expand = expand,
    oob = oob,
    position = position
  )
}


#' @rdname scalescz
#' @export
scale_x_number_cz <- function(
  name = waiver(),
  ...,
  labels,
  limits = NULL,
  expand = c(0.01, 0),
  oob = scales::censor,
  position = "bottom",
  accuracy = 1,
  scale = 1,
  prefix = "",
  suffix = "",
  big.mark = " ",
  decimal.mark = ",",
  trim = TRUE
) {
  if (missing(labels)) {
    labels <- scale_number_labels(
      accuracy,
      scale,
      prefix,
      suffix,
      big.mark,
      decimal.mark,
      trim
    )
  }

  ggplot2::scale_x_continuous(
    name = name,
    ...,
    labels = labels,
    limits = limits,
    expand = expand,
    oob = oob,
    position = position
  )
}


#' @rdname scalescz
#' @export
scale_y_number_cz <- function(
  name = waiver(),
  ...,
  labels,
  limits = NULL,
  expand = c(0.01, 0),
  oob = scales::censor,
  position = "left",
  accuracy = 1,
  scale = 1,
  prefix = "",
  suffix = "",
  big.mark = " ",
  decimal.mark = ",",
  trim = TRUE
) {
  if (missing(labels)) {
    labels <- scale_number_labels(
      accuracy,
      scale,
      prefix,
      suffix,
      big.mark,
      decimal.mark,
      trim
    )
  }

  ggplot2::scale_y_continuous(
    name = name,
    ...,
    labels = labels,
    limits = limits,
    expand = expand,
    oob = oob,
    position = position
  )
}


#' Continuous position scales with English number and percent labels
#'
#' English-locale counterparts of [scale_x_percent_cz()] and friends:
#' [ggplot2::scale_x_continuous()] and [ggplot2::scale_y_continuous()] with
#' percent labels (`"%"` suffix, decimal point) or comma labels (comma as the
#' thousands separator). These replace the functions formerly re-exported from
#' `{hrbrthemes}` and keep their defaults.
#'
#' @inheritParams scalescz
#'
#' @return A ggplot2 scale.
#' @export
#' @name scalesen
#' @examples
#' library(reschola)
#' library(ggplot2)
#' ggplot(mpg, aes(hwy * 1000, cty / max(cty))) +
#'   geom_point() +
#'   theme_schola(family = "sans", title_family = "sans", gridlines = "scatter") +
#'   scale_y_percent(accuracy = .1) +
#'   scale_x_comma()
scale_x_percent <- function(
  name = waiver(),
  ...,
  labels,
  limits = NULL,
  expand = c(0.01, 0),
  oob = scales::censor,
  position = "bottom",
  accuracy = 1,
  scale = 100,
  prefix = "",
  suffix = "%",
  big.mark = " ",
  decimal.mark = ".",
  trim = TRUE
) {
  if (missing(labels)) {
    labels <- scale_number_labels(
      accuracy,
      scale,
      prefix,
      suffix,
      big.mark,
      decimal.mark,
      trim
    )
  }

  ggplot2::scale_x_continuous(
    name = name,
    ...,
    labels = labels,
    limits = limits,
    expand = expand,
    oob = oob,
    position = position
  )
}


#' @rdname scalesen
#' @export
scale_y_percent <- function(
  name = waiver(),
  ...,
  labels,
  limits = NULL,
  expand = c(0.01, 0),
  oob = scales::censor,
  position = "left",
  accuracy = 1,
  scale = 100,
  prefix = "",
  suffix = "%",
  big.mark = " ",
  decimal.mark = ".",
  trim = TRUE
) {
  if (missing(labels)) {
    labels <- scale_number_labels(
      accuracy,
      scale,
      prefix,
      suffix,
      big.mark,
      decimal.mark,
      trim
    )
  }

  ggplot2::scale_y_continuous(
    name = name,
    ...,
    labels = labels,
    limits = limits,
    expand = expand,
    oob = oob,
    position = position
  )
}


#' @rdname scalesen
#' @export
scale_x_comma <- function(
  name = waiver(),
  ...,
  labels,
  limits = NULL,
  expand = c(0.01, 0),
  oob = scales::censor,
  position = "bottom",
  accuracy = 1,
  scale = 1,
  prefix = "",
  suffix = "",
  big.mark = ",",
  decimal.mark = ".",
  trim = TRUE
) {
  if (missing(labels)) {
    labels <- scale_number_labels(
      accuracy,
      scale,
      prefix,
      suffix,
      big.mark,
      decimal.mark,
      trim
    )
  }

  ggplot2::scale_x_continuous(
    name = name,
    ...,
    labels = labels,
    limits = limits,
    expand = expand,
    oob = oob,
    position = position
  )
}


#' @rdname scalesen
#' @export
scale_y_comma <- function(
  name = waiver(),
  ...,
  labels,
  limits = NULL,
  expand = c(0.01, 0),
  oob = scales::censor,
  position = "left",
  accuracy = 1,
  scale = 1,
  prefix = "",
  suffix = "",
  big.mark = ",",
  decimal.mark = ".",
  trim = TRUE
) {
  if (missing(labels)) {
    labels <- scale_number_labels(
      accuracy,
      scale,
      prefix,
      suffix,
      big.mark,
      decimal.mark,
      trim
    )
  }

  ggplot2::scale_y_continuous(
    name = name,
    ...,
    labels = labels,
    limits = limits,
    expand = expand,
    oob = oob,
    position = position
  )
}


#' Czech formatted scales for ggplot2
#'
#' `label_percent_cz()` returns a formatter that outputs percent labels with a " %" suffix and a decimal comma.
#' `label_number_cz()` uses space as thousand separator and decimal comma.
#' Use these when you need to format labels on something other than X and Y axes
#'
#' @inheritParams scales::number_format
#'
#' @name formatscz
#' @export
#' @examples
#' library(reschola)
#' library(ggplot2)
#' ggplot(mpg, aes(hwy, cty)) +
#'   geom_point(aes(colour = cty / max(cty), size = hwy * 100)) +
#'   theme_schola(family = "sans", title_family = "sans", gridlines = "scatter") +
#'   scale_color_binned(labels = label_percent_cz()) +
#'   scale_size_binned(labels = label_number_cz())
label_percent_cz <- function(
  accuracy = NULL,
  scale = 100,
  prefix = "",
  suffix = " %",
  big.mark = " ",
  decimal.mark = ",",
  trim = TRUE,
  ...
) {
  scales::number_format(
    accuracy = accuracy,
    scale = scale,
    prefix = prefix,
    suffix = suffix,
    big.mark = big.mark,
    decimal.mark = decimal.mark,
    trim = trim,
    ...
  )
}

#' @inheritParams scales::number_format
#'
#' @name formatscz
#' @export
label_number_cz <- function(
  accuracy = NULL,
  scale = 1,
  prefix = "",
  suffix = "",
  big.mark = " ",
  decimal.mark = ",",
  trim = TRUE,
  ...
) {
  # scales:::force_all(accuracy, scale, prefix, suffix, big.mark, decimal.mark,
  #           trim, ...)
  function(x) {
    scales::number(
      x,
      accuracy = accuracy,
      scale = scale,
      prefix = prefix,
      suffix = suffix,
      big.mark = big.mark,
      decimal.mark = decimal.mark,
      trim = trim,
      ...
    )
  }
}

label_percent_cz_abs <- function(
  accuracy = NULL,
  scale = 100,
  prefix = "",
  suffix = " %",
  big.mark = " ",
  decimal.mark = ",",
  trim = TRUE,
  ...
) {
  # scales:::force_all(accuracy, scale, prefix, suffix, big.mark, decimal.mark,
  #                   trim, ...)
  function(x) {
    scales::number(
      abs(x),
      accuracy = accuracy,
      scale = scale,
      prefix = prefix,
      suffix = suffix,
      big.mark = big.mark,
      decimal.mark = decimal.mark,
      trim = trim,
      ...
    )
  }
}

# nolint end
