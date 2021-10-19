
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
#' @family Workflow helpers
#' @examples
#' \dontrun{
#' gd_url <- "https://drive.google.com/drive/folders/1bCyR_VKAP_43NEujqisjN77hANnMKfHZ"
#' gd_download_folder(
#'   folder_url = gd_url,
#'   files_from_subfolders = T, overwrite = T
#' )
#' }
#'
#' @importFrom purrr walk2 map_chr
#' @importFrom usethis ui_path ui_info
#' @importFrom dplyr mutate filter
#' @importFrom googledrive as_id as_dribble is_folder drive_ls drive_download
#'
#' @export
#'
gd_download_folder <- function(folder_url, dest_dir = "data/input",
                               files_from_subfolders = F,
                               overwrite = F) {
  url_id <- as_id(folder_url)
  url_dribble <- as_dribble(folder_url)


  stopifnot(is_folder(url_dribble))

  if (files_from_subfolders) ui_info("Downloading files from subdirectories also into {ui_path(dest_dir)} (no subdirectories will be created).")

  drv_items <- drive_ls(url_id, recursive = files_from_subfolders)

  drv_files <- drv_items %>%
    mutate(mimetype = map_chr(drive_resource, "mimeType")) %>%
    filter(mimetype != "application/vnd.google-apps.folder")

  # print(drv_files)

  walk2(
    drv_files$id, drv_files$name,
    ~ drive_download(as_id(.x),
      path = file.path(dest_dir, .y),
      overwrite = overwrite
    )
  )

  invisible(file.path(dest_dir, drv_files$name))
}


#' Upload a file to a Google Drive folder
#'
#' FUNCTION_DESCRIPTION
#'
#' @param file path to file
#' @param target_folder Google Drive Folder URL, defaults to gd_url
#'
#' @return RETURN_DESCRIPTION
#' @examples
#' # ADD_EXAMPLES_HERE
# gd_upload_file <- function(file, target_folder = gd_url) {
#   folder_dribble <- googledrive::as_dribble(target_folder)
#   googledrive::drive_upload(file, folder_dribble)
# }
