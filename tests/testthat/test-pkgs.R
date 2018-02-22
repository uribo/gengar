context("test-pkgs.R")

test_that("multiplication works", {

  expect_s3_class(
    session_pkgs(sessionInfo()),
    "data.frame"
  )
  expect_named(
    session_pkgs(sessionInfo()),
    c("package", "version", "attached")
  )
  expect_equal(
    session_pkgs(sessionInfo()) %>%
      purrr::map_chr(class) %>% unname(),
    c("character", "character", "logical")
  )

  expect_identical(
    session_pkgs(sessioninfo::package_info()),
    session_pkgs(sessioninfo::session_info()$packages)
  )

})
