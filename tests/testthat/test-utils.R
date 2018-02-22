context("test-utils.R")

test_that("convert session info to data.frame", {

  info <- sessionInfo()

  expect_gte(
    length(modify_sessioninfo(first_info)),
    16L
  )
  expect_gte(
    length(salvage_pkgs_elements(info)),
    1L
  )

  expect_s3_class(
    session_pkgs_to_df(first_info),
    "data.frame"
  )
  expect_equal(
    ncol(session_pkgs_to_df(sessionInfo())),
    6L
  )
  expect_equal(
    ncol(session_pkgs_to_df(sessionInfo(), include_base = FALSE)),
    6L
  )

  session_pkgs_to_df(info = 'R version 3.4.3 (2017-11-30)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Debian GNU/Linux 9 (stretch)

Matrix products: default
BLAS: /usr/lib/openblas-base/libblas.so.3
LAPACK: /usr/lib/libopenblasp-r0.2.19.so

locale:
[1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_US.UTF-8
[4] LC_COLLATE=en_US.UTF-8     LC_MONETARY=en_US.UTF-8    LC_MESSAGES=C
[7] LC_PAPER=en_US.UTF-8       LC_NAME=C                  LC_ADDRESS=C
[10] LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base

other attached packages:
[1] testthat_2.0.0    gengar_0.0.0.9000

loaded via a namespace (and not attached):
[1] Rcpp_0.12.15      rstudioapi_0.7    rematch2_2.0.1    xml2_1.2.0
[5] magrittr_1.5      roxygen2_6.0.1    devtools_1.13.5   R6_2.2.2
[9] rlang_0.2.0       stringr_1.3.0     tools_3.4.3       sessioninfo_1.0.0
[13] utf8_1.1.3        cli_1.0.0         withr_2.1.1       commonmark_1.4
[17] assertthat_0.2.0  yaml_2.1.16       digest_0.6.15     tibble_1.4.2
[21] crayon_1.3.4      purrr_0.2.4       clisymbols_1.2.0  memoise_1.1.0
[25] stringi_1.1.6     compiler_3.4.3    pillar_1.1.0')

})
