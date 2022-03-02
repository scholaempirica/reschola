library(reschola)
library(tidyverse)
library(here)

source("shared.R")

# download all data from GDrive folder set in `shared.R` into `data/input`
try(gd_download_folder(gd_get_proj(), files_from_subfolders = TRUE))
