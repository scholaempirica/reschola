
#' Plot standard Schola likert-like barplot with groupwise comparison per items
#'
#' @description `r lifecycle::badge("maturing")`
#'
#'   TODO description...
#'
#' @details TODO details...
#'
#' @param .data data with items and group variable
#' @param vars vector of items, supports {tidyselect} syntax (i.e, non-standard
#'   evaluation)
#' @param group group variable used to split the results, have to be logical,
#'   where `TRUE` is gonna be considered as "focal" group and displayed as upper
#'   group with full opacity. Supports {tidyselect} syntax.
#' @param n_breaks number of breaks displayed at x-axis, outer labels are
#'   automatically aligned to face inward. Defaults to 11, which results in 10%
#'   wide breaks.
#' @param dict item code-label dictionary, if none provided, those are derived
#'   from the data.
#' @param escape_level *character*, level of item response considered as NA
#' @param desc sor items in descending order?
#' @param labels draw labels?
#' @param min_label_width smallest percentage (0-1) to display in the plot,
#'   proportions larger than this value are shown, smaller are not.
#' @param absolute_counts draw labels and absolute counts in parentheses?
#' @param fill_labels character vector or function taking breaks and returning
#'   labels for fill aesthetic
#' @param order_by how to order the items. chi-square differences (default)
#'   computes chi-square test for every item and sort them by largest X2
#'   statistic to smallest (if desc = TRUE)
#' @param reverse if TRUE, reverse colors
#' @param facet_label_wrap width of facet label to wrap
#' @param fill_cols colors to be used for item categories, defaults to NULL,
#'   meaning standard RdYlBu palette will be used
#' @param drop Drop unobserved levels form the legend? Defaults to `FALSE`. See
#'   [ggplot2::discrete_scale] for more details.
#' @param drop_na Drop `NA`s from every item (a.k.a. "pairwise")? Defaults to
#'   `TRUE`. Note that the number of observations per item may differ, because
#'   `NA` in one item does not mean the respondent row is discarded completely
#'   (listwise).
#'
#' @inheritDotParams fct_nanify -f -level
#'
#' @family Making charts
#'
#' @return object of class "gg", "ggplot"
#' @export
#'
#' @importFrom ggtext element_markdown
#' @importFrom rlang abort eval_tidy
#' @importFrom forcats fct_relevel fct_rev
#' @importFrom dplyr pull group_by arrange if_else summarise n ungroup select
#' @importFrom stringr str_wrap
#' @importFrom stats median
#' @importFrom purrr pluck map_dbl
#' @importFrom ggplot2 waiver
#' @importFrom tidyr pivot_longer nest drop_na
#' @importFrom scales percent number
#' @importFrom RColorBrewer brewer.pal
#'
schola_barplot <- function(.data, vars, group, dict = dict_from_data(.data),
                           escape_level = "nev\u00edm", n_breaks = 11, desc = TRUE,
                           labels = TRUE, min_label_width = .09, absolute_counts = TRUE,
                           fill_cols = NULL, fill_labels = waiver(), facet_label_wrap = 115,
                           reverse = FALSE, order_by = "chi-square differences",
                           drop = FALSE, drop_na = TRUE, ...) {
  if (!is.logical(eval_tidy(enquo(group), .data))) abort("`group` variable have to be logical.")
  order_by <- match.arg(order_by, c("chi-square differences", "weighted total scores"))
  # data --------------------------------------------------------------------

  long_data <- .data %>%
    pivot_longer({{ vars }}, names_to = ".item", values_to = ".resp")

  # drop NAs column-wise, not excludig rows with just ANY NA present
  if (drop_na) {
    long_data <- long_data %>% drop_na(.resp)
  }


  if (order_by == "weighted total scores") {

    # get counts for each response category, multiply by its .resp to get "weight" of some sort
    #  -- higher usage of higher categories results in higher weight
    item_order <- long_data %>%
      mutate(resp_num = fct_nanify(.data$.resp, escape_level, ...) %>% as.integer()) %>%
      group_by({{ group }}, .data$.item) %>%
      summarise(ts = sum(.data$resp_num, na.rm = TRUE)) %>%
      filter({{ group }}) %>%
      arrange(desc(.data$ts)) %>%
      pull(.data$.item)
  }


  plt_data <- long_data %>%
    mutate(.resp = fct_rev(.data$.resp)) %>%
    group_by({{ group }}, .data$.item, .data$.resp) %>%
    summarise(n = n(), .groups = "drop_last")

  if (order_by == "chi-square differences") {
    item_order <- plt_data %>%
      pivot_wider(names_from = .data$.resp, values_from = .data$n, values_fill = 0) %>%
      group_by(.data$.item) %>%
      select(-.data$digest) %>%
      nest() %>%
      mutate(chsq = map_dbl(.data$data, ~ suppressWarnings(chisq.test(.x)) %>% pluck("statistic"))) %>%
      arrange(desc(.data$chsq)) %>%
      pull(.data$.item)
  }

  if (!desc) item_order <- rev(item_order)


  plt_data <- plt_data %>%
    mutate(
      prop = .data$n / sum(.data$n),
      label = percent(.data$prop, 1, suffix = " %") # category size threshold for label to display
    ) %>%
    ungroup() %>%
    mutate(.item = fct_relevel(as.factor(.data$.item), item_order)) # sort facets according order table


  if (absolute_counts) {
    plt_data <- plt_data %>% mutate(label = paste0(.data$label, " (", number(.data$n, 1), ")"))
  }

  plt_data <- plt_data %>% mutate(
    label = if_else(.data$prop > min_label_width, .data$label, NA_character_)
  )

  # helper values -----------------------------------------------------------

  axis_x_breaks <- seq(0, 1, length.out = n_breaks)
  axis_x_hjust <- c(0, rep(.5, n_breaks - 2), 1)

  n_cats <- plt_data %>%
    pull(.data$.resp) %>%
    levels() %>%
    length()

  n_fill_cols <- if (escape_level == FALSE) n_cats else n_cats - 1L

  legend_cols <- c(
    if (escape_level != FALSE) "#dadada" else NULL,
    if (reverse) {
      brewer.pal(n_fill_cols, "RdYlBu")
    } else {
      rev(brewer.pal(n_fill_cols, "RdYlBu"))
    }
  )

  # overwrite the palette if custom cols are provided
  if (!is.null(fill_cols)) {
    legend_cols <- if (reverse) {
      fill_cols
    } else {
      rev(fill_cols)
    }
  }



  # plot --------------------------------------------------------------------

  # conditional labels geom
  labels <- if (labels) {
    geom_text(
      aes(
        label = .data$label,
        col = after_scale(if_else(get_lightness(.data$fill) > .5, "grey30", "white"))
      ),
      position = position_fill(vjust = .5), size = 3, na.rm = TRUE
    )
  }

  plt_data %>%
    ggplot(aes(
      y = {{ group }}, x = .data$prop,
      fill = .data$.resp
    )) +
    geom_col(width = .75, position = "fill", col = "white", size = .4) +
    labels +
    facet_wrap(
      ~ .data$.item,
      ncol = 1, drop = FALSE, labeller = schola_labeller(dict, width = facet_label_wrap)
    ) +
    scale_x_percent_cz(
      limits = c(0, 1), breaks = axis_x_breaks, expand = expansion()
    ) +
    scale_y_discrete(limits = c(FALSE, TRUE), labels = c("", "*")) +
    scale_fill_manual(values = legend_cols, labels = fill_labels, drop = drop) +
    guides(fill = guide_legend(
      title = NULL, nrow = 1, reverse = TRUE,
      override.aes = list(size = .75, col = NULL)
    )) +
    theme_schola("x") +
    theme(
      axis.text.x = element_markdown(hjust = axis_x_hjust, colour = "grey30"), # element_text does not support vectorised input, see https://github.com/tidyverse/ggplot2/issues/3492
      axis.text.y = element_text(size = 18, face = "bold", vjust = .73), # not much appealing, but asterisk suites the plot best according to our focus group
      axis.title = element_blank(),
      panel.spacing = unit(11, "pt"),
      strip.text = element_text(
        colour = "grey30", size = 10, hjust = 0, vjust = 0,
        margin = margin(0, 0, 3, 1.5)
      ),
      panel.grid.major.x = element_line(colour = "grey88"),
      legend.position = "bottom"
    )
  # FIXME - set xlim to accommodate strlen of labels
}


#' Labeller with width wrapping and item code-label dictionary
#'
#' Turns item codes into labels by looking up provided dictionary and applies
#' them as facet labels.
#'
#' @param dict code-label dictionary as named character vector, see
#'   `dict_from_data()`
#' @param width maximal string length per line, if `NULL`, this is off
#'
#' @return object of class `labeller`, to be used in `facet_*` {ggplot2}
#'   functions.
#' @export
#' @importFrom rlang set_names
#'
schola_labeller <- function(dict, width = 80) {
  fun <- function(item_codes) {
    item_codes <- lapply(item_codes, as.character)
    labels <- lapply(item_codes, function(label) {
      unmatched_labels <- set_names(label[!label %in% names(dict)])
      dict <- c(dict, unmatched_labels)
      out <- dict[label]

      if (length(unmatched_labels) != 0) {
        warning(
          "There were unmatched labels for item codes:\n",
          paste(unmatched_labels, collapse = ", "), ".",
          call. = FALSE
        )
      }

      out
    })

    if (!is.null(width)) {
      labels <- lapply(labels, function(label) {
        str_wrap(label, width = width)
      })
    }
    labels
  }
  structure(fun, class = "labeller")
}



#' Extract perceived lightness from colour
#'
#' @param col colour .item or hex
#'
#' @return L .resp from HSL-converted model
#' @keywords internal
#' @importFrom grDevices col2rgb
#'
get_lightness <- function(col) {
  # convert color to RGB, scale to 0-1, get min/max and compute L of HSL color
  rgb_col <- col2rgb(col)
  rgb_col_scaled <- rgb_col / 255
  cmin <- apply(rgb_col_scaled, 2, min)
  cmax <- apply(rgb_col_scaled, 2, max)
  (cmax + cmin) / 2
}



#' Get item code-label dictionary from data
#'
#' Item labels have to be stored as variable attribute `label`. Exported by
#' default by `ls_export()`, but many data wrangling operations strip them out,
#' unfortunately.
#'
#' @param .data data.frame or tibble
#'
#' @return named character vector of items' labels, if no label found, NULL is
#'   introduced and is omitted in the output
#' @export
#'
#' @importFrom purrr map
#'
dict_from_data <- function(.data) {
  # try parent.frame()
  out <- .data %>%
    map(~ attr(.x, "label")) %>%
    unlist()

  if (is.null(out)) warning("No labels were retrieved from the data. Please, provide the dictionary manually.", call. = FALSE)

  out
}
