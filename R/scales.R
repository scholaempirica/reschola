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

scale_x_comma_cz <- function (name = waiver(), breaks = waiver(), minor_breaks = waiver(),
                              labels = scales::comma, limits = NULL, expand = expans,
                              oob = censor, na.value = NA_real_, trans = "identity", position = "left",
                              sec.axis = waiver())
{
  sc <- ggplot2::continuous_scale(c("y", "ymin", "ymax", "yend",
                                    "yintercept", "ymin_final", "ymax_final", "lower", "middle",
                                    "upper"), "position_c", identity, name = name, breaks = breaks,
                                  minor_breaks = minor_breaks, labels = labels, limits = limits,
                                  expand = expand, oob = oob, na.value = na.value, trans = trans,
                                  guide = "none", position = position, super = ScaleContinuousPosition)
  if (!is.waive(sec.axis)) {
    if (is.formula(sec.axis))
      sec.axis <- ggplot2::sec_axis(sec.axis)
    if (!is.sec_axis(sec.axis))
      stop("Secondary axes must be specified using 'sec_axis()'")
    sc$secondary.axis <- sec.axis
  }
  sc
}
