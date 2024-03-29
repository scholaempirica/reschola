% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{get_labs_df}
\alias{get_labs_df}
\title{Get labels of variables}
\usage{
get_labs_df(.data)
}
\arguments{
\item{.data}{tibble or data.frame}
}
\value{
tibble with variables and its labels (as list-column)
}
\description{
Get labels of variables
}
\examples{
# make labels for iris dataset, labels will be colnames
# with dot replaced for whitespace
iris_with_labs <- as.data.frame(mapply(function(x, y) {
  attr(x, "label") <- y
  return(x)
}, iris, gsub("\\\\.", " ", colnames(iris)), SIMPLIFY = FALSE))

get_labs_df(iris_with_labs)

}
