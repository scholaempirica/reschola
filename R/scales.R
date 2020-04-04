
# Stolen from ggplot2 via hrbrthemes
is.waive <- function (x) { inherits(x, "waiver") }
is.sec_axis <- function (x) { inherits(x, "AxisSecondary") }
is.formula <- function (x) { inherits(x, "formula") }

## taken from ratlas

#' @importFrom hrbrthemes scale_x_comma
#' @export
hrbrthemes::scale_x_comma
#' @importFrom hrbrthemes scale_y_comma
#' @export
hrbrthemes::scale_y_comma
#' @importFrom hrbrthemes scale_x_percent
#' @export
hrbrthemes::scale_x_percent
#' @importFrom hrbrthemes scale_y_percent
#' @export
hrbrthemes::scale_y_percent
#' @importFrom hrbrthemes gg_check
#' @export
hrbrthemes::gg_check

#' @export
scale_x_percent_cz <- function(name = waiver(),
                            breaks = waiver(),
                            minor_breaks = waiver(),
                            guide = waiver(),
                            n.breaks = NULL,
                            labels,
                            limits = NULL,
                            expand = c(0.01,0),
                            oob = scales::censor,
                            na.value = NA_real_,
                            trans = "identity",
                            position = "bottom",
                            sec.axis = waiver(),
                            accuracy = 1,
                            scale = 100,
                            prefix = "",
                            suffix = " %",
                            big.mark = " ",
                            decimal.mark = ",",
                            trim = TRUE, ...) {

  if (missing(labels)) {
    scales::percent_format(
      accuracy = accuracy,
      scale = scale,
      prefix = prefix,
      suffix = suffix,
      big.mark = big.mark,
      decimal.mark = decimal.mark,
      trim = trim,
      ...
    ) -> labels
  }

  ggplot2::continuous_scale(
    aesthetics = c(
      "x", "xmin", "xmax", "xend", "xintercept", "xmin_final",
      "xmax_final", "xlower", "xmiddle", "xupper", "x0"
    ),
    scale_name = "position_c",
    palette = identity,
    name = name,
    breaks = breaks,
    n.breaks = n.breaks,
    minor_breaks = minor_breaks,
    labels = labels,
    limits = limits,
    expand = expand,
    oob = oob,
    na.value = na.value,
    trans = trans,
    guide = guide,
    position = position,
    super = ScaleContinuousPosition
  ) -> sc


  if (!is.waive(sec.axis)) {

    if (is.formula(sec.axis)) sec.axis <- sec_axis(sec.axis)
    if (!is.sec_axis(sec.axis)) stop("Secondary axes must be specified using 'sec_axis()'")

    sc$secondary.axis <- sec.axis

  }

  sc

}


#' @export
scale_y_percent_cz <- function(name = waiver(),
                            breaks = waiver(),
                            minor_breaks = waiver(),
                            guide = waiver(),
                            n.breaks = NULL,
                            labels,
                            limits = NULL,
                            expand = c(0.01,0),
                            oob = scales::censor,
                            na.value = NA_real_,
                            trans = "identity",
                            position = "left",
                            sec.axis = waiver(),
                            accuracy = 1,
                            scale = 100,
                            prefix = "",
                            suffix = " %",
                            big.mark = " ",
                            decimal.mark = ",",
                            trim = TRUE, ...) {

  if (missing(labels)) {
    scales::percent_format(
      accuracy = accuracy,
      scale = scale,
      prefix = prefix,
      suffix = suffix,
      big.mark = big.mark,
      decimal.mark = decimal.mark,
      trim = trim,
      ...
    ) -> labels
  }

  ggplot2::continuous_scale(
    aesthetics = c(
      "y", "ymin", "ymax", "yend", "yintercept",
      "ymin_final", "ymax_final", "lower", "middle", "upper"
    ),
    scale_name = "position_c",
    palette = identity,
    name = name,
    breaks = breaks,
    n.breaks = n.breaks,
    minor_breaks = minor_breaks,
    labels = labels,
    limits = limits,
    expand = expand,
    oob = oob,
    na.value = na.value,
    trans = trans,
    guide = guide,
    position = position,
    super = ScaleContinuousPosition
  ) -> sc

  if (!is.waive(sec.axis)) {

    if (is.formula(sec.axis)) sec.axis <- ggplot2::sec_axis(sec.axis)
    if (!is.sec_axis(sec.axis)) stop("Secondary axes must be specified using 'sec_axis()'")

    sc$secondary.axis <- sec.axis

  }

  sc

}

label_percent_cz <- function (accuracy = NULL, scale = 100, prefix = "", suffix = " %",
                              big.mark = " ", decimal.mark = ",", trim = TRUE, ...)
{
  scales::number_format(accuracy = accuracy, scale = scale, prefix = prefix,
                suffix = suffix, big.mark = big.mark, decimal.mark = decimal.mark,
                trim = trim, ...)
}

label_number_cz <- function (accuracy = NULL, scale = 1, prefix = "", suffix = "",
                             big.mark = " ", decimal.mark = ",", trim = TRUE, ...)
{
  scales:::force_all(accuracy, scale, prefix, suffix, big.mark, decimal.mark,
            trim, ...)
  function(x) scales::number(x, accuracy = accuracy, scale = scale,
                     prefix = prefix, suffix = suffix, big.mark = big.mark,
                     decimal.mark = decimal.mark, trim = trim, ...)
}

label_percent_cz_abs <- function(accuracy = NULL, scale = 100, prefix = "", suffix = " %",
                      big.mark = " ", decimal.mark = ",", trim = TRUE, ...)
{
  scales:::force_all(accuracy, scale, prefix, suffix, big.mark, decimal.mark,
                    trim, ...)
  function(x) scales::number(abs(x), accuracy = accuracy, scale = scale,
                             prefix = prefix, suffix = suffix, big.mark = big.mark,
                             decimal.mark = decimal.mark, trim = trim, ...)

}
