
#' Download files from Google Drive folder
#'
#' Downloads all downloadable files from given Google Drive folder
#' and saves them to specified local directory. Files will have the same names.
#' Use `googledrive::drive_download()` for downloading individual files.
#'
#' @note As it would be very difficult to mirror the folder exactly,
#' if `files_from_subfolders` is set to `TRUE`, files from subfolders will be
#' saved in the same directory, not in the respective subdirectories.
#' Bear this in mind when naming files in GDrive subfolders so as to avoid naming conflicts.
#'
#' @param folder_url Folder URL.
#' @param dest_dir Local URL in which to store files.
#' @param files_from_subfolders Whether to download also files from subdirectories.
#'   Defaults to `TRUE`. See Note.
#' @param overwrite Whether to overwrite if file of same name exists.
#'
#' @return vector of paths to downloaded files
#' @examples
#' \dontrun{
#' gd_url <- "https://drive.google.com/drive/folders/1bCyR_VKAP_43NEujqisjN77hANnMKfHZ"
#' gd_download_folder(folder_url = gd_url,
#'                    files_from_subfolders = T, overwrite = T)
#' }
#' @export
gd_download_folder <- function(folder_url, dest_dir = "data-input",
                               files_from_subfolders = F,
                               overwrite = F) {
  url_id <- googledrive::as_id(folder_url)
  url_dribble <- googledrive::as_dribble(folder_url)


  stopifnot(googledrive::is_folder(url_dribble))

  if(files_from_subfolders) usethis::ui_info("Downloading files from subdirectories also into {usethis::ui_path(dest_dir)} (no subdirectories will be created).")

  drv_items <- googledrive::drive_ls(url_id, recursive = files_from_subfolders)

  drv_files <- drv_items %>%
    dplyr::mutate(mimetype = purrr::map_chr(drive_resource, 'mimeType')) %>%
    dplyr::filter(mimetype != "application/vnd.google-apps.folder")

  # print(drv_files)

  purrr::walk2(drv_files$id, drv_files$name,
               ~googledrive::drive_download(googledrive::as_id(.x),
                                            path = file.path(dest_dir, .y),
                                            overwrite = overwrite))

  invisible(file.path(dest_dir, drv_files$name))
}
