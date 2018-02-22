context("test-session.R")

test_that("session information", {

  info <- sessionInfo()
  expect_s3_class(
    info,
    "sessionInfo"
  )
  expect_true(
    is_sessioninfo(sessionInfo())
  )
  expect_true(
    is_sessioninfo(devtools::session_info())
  )
  expect_true(
    is_sessioninfo(sessioninfo::session_info())
  )
  expect_false(
    is_sessioninfo(letters)
  )

  expect_true(
    session_include_pkgs_df(devtools::session_info())
  )
  expect_true(
    session_include_pkgs_df(sessioninfo::session_info())
  )

  expect_false(
    session_include_pkgs_df(sessionInfo())
  )
  expect_false(
    session_include_pkgs_df(letters)
  )

})
