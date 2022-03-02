.onAttach <- function(libname, pkgname) {
  packageStartupMessage(paste0("This is {reschola} version ", packageVersion("reschola")))
  register_reschola_fonts()
}
