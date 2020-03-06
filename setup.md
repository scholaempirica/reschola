# How this package was created

```r
usethis::create_package("reschola")
usethis::use_description()
usethis::use_mit_license() # needs manual fixing, see e.g. https://github.com/petrbouchal/statnipokladna/

usethis::use_readme_rmd()
usethis::use_roxygen_md()
usethis::use_news_md()
usethis::use_package_doc()

usethis::use_pipe()

usethis::use_git()
usethis::use_github(organisation = "scholaempirica")
usethis::use_github_links() # in fact happened automatically with the previous

usethis::use_travis()
travis::use_travis_deploy()

usethis::use_pkgdown()
usethis::use_pkgdown_travis()

renv::activate() # need to edit .travis.yml manually Las per renv CI vignette
```
