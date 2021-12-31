

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
#' @param min_label_width minimal label width that is displayed in the plot
#' @param absolute_counts draw labels and absolute counts in parentheses?
#' @inheritDotParams fct_nanify -f -level
#'
#' @return object of class "gg", "ggplot"
#' @export
#'
#' @importFrom ggtext element_markdown
#' @importFrom rlang abort eval_tidy
#' @importFrom forcats fct_relevel fct_rev
#' @importFrom dplyr pull group_by arrange if_else summarise n
#' @importFrom stringr str_wrap
#' @importFrom stats median
#' @importFrom tidyr pivot_longer
#' @importFrom scales percent
#'
schola_barplot <- function(.data, vars, group, dict = dict_from_data(.data),
                           escape_level = "nev\\u00edm", n_breaks = 11, desc = TRUE,
                           labels = TRUE, min_label_width = .08, absolute_counts = TRUE, ...) {
  if (!is.logical(eval_tidy(enquo(group), .data))) abort("`group` variable have to be logical.")

  # data --------------------------------------------------------------------

  long_data <- .data %>%
    pivot_longer({{ vars }}, names_to = ".item", values_to = ".resp")

  # get counts for each response category, multiply by its .resp to get "weight" of some sort
  #  -- higher usage of higher categories results in higher weight
  item_order <- long_data %>%
    mutate(resp_num = fct_nanify(.data$.resp, escape_level, ...) %>% as.integer()) %>%
    group_by({{ group }}, .data$.item) %>%
    summarise(ts = sum(.data$resp_num, na.rm = TRUE)) %>%
    filter({{ group }}) %>%
    arrange(desc(.data$ts)) %>%
    pull(.data$.item)


  if (!desc) item_order <- rev(item_order)


  plt_data <- long_data %>%
    mutate(
      .item = fct_relevel(.data$.item, item_order), # sort facets according order table
      .resp = fct_rev(.data$.resp)
    ) %>%
    group_by({{ group }}, .data$.item, .data$.resp) %>%
    summarise(n = n(), .groups = "drop_last") %>%
    mutate(
      prop = .data$n / sum(.data$n),
      label = percent(.data$prop, 1, suffix = " %") # category size threshold for label to display
    )

  if (absolute_counts) {
    plt_data <- plt_data %>% mutate(label = paste0(.data$label, " (", n, ")"))
  }

  plt_data <- plt_data %>% mutate(
    label = if_else(.data$prop > min_label_width, .data$label, NA_character_)
  )

  # helper values -----------------------------------------------------------

  axis_x_breaks <- seq(0, 1, length.out = n_breaks)
  axis_x_hjust <- c(0, rep(.5, n_breaks - 2), 1)

  cats <- plt_data %>%
    pull(.data$.resp) %>%
    levels()
  legend_cols <- c("#dadada", rev(RColorBrewer::brewer.pal(length(cats) - 1, "RdYlBu")))


  # plot --------------------------------------------------------------------

  # conditional labels geom
  labels <- if (labels) {
    geom_text(
      aes(
        label = label,
        col = after_scale(if_else(get_lightness(.data$fill) > .5, "grey30", "white"))
      ),
      position = position_fill(vjust = .5), size = 3, na.rm = TRUE
    )
  }

  plt_data %>%
    ggplot(aes(
      y = {{ group }}, x = .data$prop,
      fill = .data$.resp, alpha = {{ group }}
    )) +
    geom_col(width = .75, position = "fill", col = "white", size = .4) +
    labels +
    facet_wrap(
      ~.data$.item,
      ncol = 1, drop = FALSE, labeller = schola_labeller(dict)
    ) +
    scale_x_percent_cz(
      limits = c(0, 1), breaks = axis_x_breaks, expand = expansion()
    ) +
    scale_fill_manual(values = legend_cols) +
    scale_alpha_manual(
      values = c(`TRUE` = 1, `FALSE` = .7), drop = FALSE, guide = "none"
    ) +
    guides(fill = guide_legend(
      title = NULL, nrow = 1, reverse = TRUE,
      override.aes = list(size = .75, col = NULL)
    )) +
    theme_schola("x") +
    theme(
      axis.text.x = element_markdown(hjust = axis_x_hjust, colour = "grey30"), # element_text does not support vectorised input, see https://github.com/tidyverse/ggplot2/issues/3492
      axis.text.y = element_blank(), # disruptive and uninformative
      axis.title = element_blank(),
      panel.spacing = unit(11, "pt"),
      strip.text = element_text(
        colour = "grey30", size = 9, hjust = 0, vjust = 0,
        margin = margin(0, 0, 3, 1.5)
      ),
      panel.grid.major.x = element_line(colour = "grey88"),
      legend.position = "top"
    )
}


#' Labeller with width wrapping and item code-label dictionary
#'
#' Turns item codes into labels by looking up provided dictionary and applies
#' them as facet labels.
#'
#' @param dict code-label dictionary as named character vector, see
#'   `dict_from_data()`
#' @param width maximal string length per line
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

    lapply(labels, function(label) {
      str_wrap(label, width = width)
    })
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
