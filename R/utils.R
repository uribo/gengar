#' @importFrom utils capture.output
modify_sessioninfo <- function(info) {
  if(class(info) == "sessionInfo")
    info <- info %>% utils::capture.output()

  info_chr <- info %>%
    strsplit("\n") %>%
    unlist() %>%
    gsub("^[[:space:]]", "", .) %>%
    gsub("^\\[[0-9]{1,99}\\]", replacement = "", .) %>%
    gsub("^[[:space:]]", "", .)

  return(info_chr)
}

salvage_pkgs_elements <- function(info) {
  info_chr <- modify_sessioninfo(info)

  results <- info_chr %>%
    grep("(packages|loaded via)", .)

  return(results)
}


session_pkgs_to_df <- function(info, include_base = TRUE, ...) {

  info_chr <- modify_sessioninfo(info)
  xxx <- salvage_pkgs_elements(info)

  df_pkg_base <- info_chr[(xxx[1] + 1):(xxx[2] - 1)] %>%
    parse_pkg_version()
  df_pkg_base$base <- TRUE
  df_pkg_base$required <- FALSE

  if (length(xxx) == 2) {
    df_pkgs_others <- info_chr[(xxx[2] + 1):(length(info_chr))] %>%
      parse_pkg_version()
    df_pkgs_others$required <- FALSE
  } else {
    df_pkgs_attached <- info_chr[(xxx[2] + 1):(xxx[3] - 1)] %>%
      parse_pkg_version()
    df_pkgs_attached$required <- TRUE

    df_pkgs_not_attached <- info_chr[(xxx[3] + 1):(length(info_chr))] %>%
      parse_pkg_version()
    df_pkgs_not_attached$required <- FALSE

    df_pkgs_others <- rbind(df_pkgs_attached, df_pkgs_not_attached)

  }
  df_pkgs_others$base <- FALSE

  result <- rbind(df_pkgs_others, df_pkg_base)

  if (include_base == FALSE)
    result <- subset(result, base == FALSE)

  return(result)
}

parse_pkg_version <- function(x) {

  x <- x %>%
    strsplit(split = "[[:space:]]") %>%
    unlist() %>%
    .[. != ""]

  result <- rematch2::re_match(x,
                               pattern = "(?<package>^[a-zA-Z0-9]{1,99})_(?<version>[0-9].+$)")

  result$package <- ifelse(is.na(result$package),
                           result$.text,
                           result$package)

  return(result)
}
