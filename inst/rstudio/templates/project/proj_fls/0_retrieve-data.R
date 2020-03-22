library(reschola)
source("shared.R")

# download all data from GDrive folder set in `shared.R` into `data-input`
reschola::gd_download_folder(gd_url, overwrite = F, files_from_subfolders = T)

# If there is other data you expect to only retrieve once
# (from the web, public databases or APIs, etc.),
# this might be a good place to store the code that does it.
