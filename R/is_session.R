#' Is identical session information object?
#'
#' @param x session information
#' @export
is_sessioninfo <- function(x) {

  result <- if (length(class(x)[class(x) %in% c("sessionInfo", "session_info", "packages_info")]) >= 1)
    TRUE
  else FALSE

  return(result)
}

#' @export
session_include_pkgs_df <- function(x) {

  if (is_sessioninfo(x)) {
    if(class(x) %in% c("data.frame", "packages_info") ||
      class(x$packages) %in% c("data.frame") %>% sum() >= 1) {
      TRUE
    } else{
      FALSE
    }
  } else {
    FALSE
  }

}
