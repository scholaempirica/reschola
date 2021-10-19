library(reschola)
library(tidyverse)
library(here)

source("shared.R")

# download all data from GDrive folder set in `shared.R` into `data/input`
gd_download_folder(gd_url, overwrite = FALSE, files_from_subfolders = TRUE)
