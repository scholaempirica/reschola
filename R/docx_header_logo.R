#' Add or replace logo in the header of a Word document
#'
#' Takes an existing Word document created using the `reschola` templates
#' and adds (by default, or replaces if `action = "replace_schola"`) the logo with
#' the image file you point it to.
#'
#' @note This requires specific bookmarks in the header of the input document.
#'   This is taken from the skeleton.docx template in the template components.
#'   If you overwrite the header in the input document, this function will not work.
#'
#' @param docx_path The Word document in which to replace logos. Must contain the bookmarks
#'   `schola_logo` and `client_logo` in the header (files created from reschola templates do by default.)
#' @param png_logo_path a PNG file which will be added/used as replacement
#' @param action whether to add new logo on the right (`"add_client"`) or
#'  replace default Schola logo on the left (`"replace_schola"`)
#' @param height height of the new logo in the resulting document, in `cm`.
#' By default, uses the height of the existing Schola logo in the header.
#'
#' @return invisibly returns the name of the new Word doc, which is same as the input Word doc,
#' with an an added `_addedlogo` suffix.
#' @export
#' @family Workflow helpers
#' @examples
#' \dontrun{
#' library(reschola)
#' manage_docx_header_logos("draft.docx",
#'   png_logo_path = "logos/newlogo.png",
#'   action = "add_client"
#' )
#' manage_docx_header_logos("draft.docx",
#'   png_logo_path = "logos/newlogo.png",
#'   action = "replace_schola"
#' )
#' }
manage_docx_header_logos <- function(docx_path, png_logo_path,
                                     action = c("add_client", "replace_schola"),
                                     height = NULL) {
  logo_action <- match.arg(action)
  bookmark_name <- ifelse(logo_action == "add_client", "logo_client", "logo_schola")
  template <- docx_path

  img_file <- file.path(png_logo_path)
  img <- png::readPNG(img_file)
  dim(img)
  img_ratio <- dim(img)[1] / dim(img)[2]
  # height of primary logo, too keep heights aligned
  if (is.null(height)) img_h_default <- 1.07 / 2.54 else img_h_default <- height / 2.54
  img_w <- img_h_default / img_ratio

  doc <- officer::read_docx(path = template)
  doc <- officer::headers_replace_img_at_bkm(
    x = doc, bookmark = bookmark_name,
    value = officer::external_img(src = img_file, height = img_h_default, width = img_w)
  )
  newfilename <- paste0(tools::file_path_sans_ext(docx_path), "_addedlogo.docx")
  print(doc, target = newfilename)
  invisible(newfilename)
}
