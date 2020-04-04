
#' FUNCTION_TITLE
#'
#' FUNCTION_DESCRIPTION
#'
#' @param data DESCRIPTION.
#'
#' @return RETURN_DESCRIPTION
#' @export
#' @import dplyr
#' @import scales
#' @import forcats
#' @import tidyr
#' @import ggplot2
#' @examples
#' # ADD_EXAMPLES_HERE
diverging_chart <- function(data) {

  df <- data

  my_levels <- c("completely agree" = "1",
                 "agree" = "2",
                 "disagree" = "3",
                 "completely disagree" = "4",
                 "don't know" = "5")

  # the same goes for my collumns
  my_cols <- names(df)[-1]

  # these are helpers for some calculations further down the script
  my_positivives <- c("completely agree","agree")
  my_negatives <- c("completely disagree","disagree")
  my_dkn <- c("don't know")


  # recode original data (numbers) to string factors
  df_mutated <- df %>%
    dplyr::mutate_at(.vars = my_cols,
              ~forcats::fct_recode(.,!!!my_levels) %>%
                forcats::fct_expand("dummy1"))

  # long format needed for plotting
  df_long <- df_mutated %>%
    pivot_longer(cols = all_of(my_cols), names_to = "variable",
                 values_to = "value") %>%
    mutate(value = as.factor(value) %>%
             fct_expand(c(names(my_levels), "dummy1"))) %>%
    complete(variable, value)


  # dataframe to be fed in ggplot2
  # vertical_2 is generated as a helper for future reference
  df_chart <-
    df_long %>%
    group_by(variable, value, .drop = FALSE) %>%
    summarise(n=n()) %>%
    mutate(prop=n/sum(n)) %>%
    mutate(pos_sum = sum(prop[value %in% my_positivives]),
           neg_sum = sum(prop[value %in% my_negatives]),
           dkn_sum = sum(prop[value %in% my_dkn])) %>%
    ungroup() %>%
    mutate(vertical_2 = max(neg_sum) + 0.2)

  # this adds dummy variables needed for the diverging chart
  # this workflow throws warnings and requires to change back to factors afterwards
  # not sure if this is good practice (having the warning there) or even OK to be part of a function
  # however, the levels order needs to be changed anyway to work in the chart

  df_chart2 <-
    bind_rows(df_chart,
              df_chart %>% distinct(variable, .keep_all = TRUE) %>%
                mutate(value = factor("dummy1") %>%
                         fct_expand(names(my_levels)),
                       n = 0,
                       prop = vertical_2 - neg_sum)) %>%
    arrange(variable)

  # chart - alternative 2
  # I have only developed this version of the chart since you all liked it more

  # basic chart
  # updates:
  # fixed legend (custom order and displayed categories)
  # axis labels (no minus signs)
  # automated grid lines - by 20%, rounded down to nearest 20 from maximum on each side
  diverging <-
    df_chart2 %>%
    ggplot(aes(y = reorder(variable, pos_sum),x = if_else(value %in% my_positivives, -prop, prop),
               fill = factor(value,
                             levels = c(my_positivives,
                                        my_dkn,
                                        "dummy1",
                                        my_negatives),
                             ordered = TRUE))) +
    geom_bar(stat = "identity", position = "stack") +
    scale_fill_manual(values = c("completely agree" = "royalblue4", "agree" = "royalblue3", "disagree" = "firebrick2",
                                 "completely disagree" = "firebrick4", "dummy1" = NA, "don't know" = "gray55"),
                      breaks = c(my_positivives, rev(my_negatives), my_dkn))+
    geom_vline(xintercept = 0, color ="gray25", size = 1) +
    geom_vline(xintercept = max(df_chart2$vertical_2), color ="gray25", size = 1) +
    labs(title = "Title",
         subtitle = "Subtitle",
         caption = "Caption")+
    theme_schola("x")+
    guides(fill = guide_legend(title = NULL))+
    theme(legend.position = "bottom") + # should we make it part of the function to easily switch between bottom and right?
    # I thought the natural x breaks were too rare, hope this is gonna work well
    scale_x_continuous(breaks = seq(-max(0:(max(df_chart2$pos_sum)*100) - (0:(max(df_chart2$pos_sum)*100) %% 20))/100 - 0.2,
                                    max(0:(max(df_chart2$neg_sum)*100) - (0:(max(df_chart2$neg_sum)*100) %% 20))/100 +0.2,
                                    0.2),
                       labels = label_percent_cz_abs())

  diverging + expand_limits(x=c(-max(df_chart2$pos_sum) - 0.1, max(df_chart2$vertical_2) + max(df_chart2$dkn_sum) + 0.1))


  # adding labels

  diverging +
    expand_limits(x=c(-max(df_chart2$pos_sum) - 0.1, max(df_chart2$vertical_2) + max(df_chart2$dkn_sum) + 0.1))+
    geom_text(data = df_chart2 %>% distinct(variable, .keep_all = TRUE),
              aes(y = reorder(variable, pos_sum),
                  x = -pos_sum,
                  hjust = "outward",
                  label=paste0(" ",round(pos_sum*100,0)," % ")),
              color = "black",
              fontface = "bold")+
    geom_text(data = df_chart2 %>% distinct(variable, .keep_all = TRUE),
              aes(y = reorder(variable, pos_sum),
                  x = neg_sum,
                  hjust = "outward",
                  label=paste0(" ",round(neg_sum*100,0)," % ")),
              color = "black",
              fontface = "bold")+
    geom_text(data = df_chart2 %>% filter(value %in% my_dkn),
              aes(y = reorder(variable, pos_sum),
                  x = vertical_2 + prop,
                  hjust = "outward",
                  label=paste0(" ",round(prop*100,0)," % ")),
              color = "black",
              fontface = "bold") # maybe this one should not be bold

}
