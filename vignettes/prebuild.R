# Precompute the "Making charts" vignette so its charts are rendered with the
# reschola fonts installed on this machine (CI may not have them).
# Run from the package root after installing the current version of reschola:
#   Rscript vignettes/prebuild.R
# See vignettes/meta.Rmd and
# https://ropensci.org/blog/2019/12/08/precompute-vignettes/
old_wd <- setwd("vignettes")
on.exit(setwd(old_wd))
knitr::knit("charts.Rmd.orig", output = "charts.Rmd")
