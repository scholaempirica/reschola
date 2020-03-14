library(officer)
template <- system.file(package = "officer", "doc_examples/example.docx")

img.file <- file.path(R.home("doc"), "html", "logo.jpg")

doc <- read_docx(path = template)
doc <- headers_replace_img_at_bkm(
  x = doc, bookmark = "bmk_header",
  value = external_img(src = img.file, width = .53, height = .7)
)
doc <- footers_replace_img_at_bkm(
  x = doc, bookmark = "bmk_footer",
  value = external_img(src = img.file, width = .53, height = .7)
)
print(doc, target = tempfile(fileext = ".docx"))
