#' @export
session_pkgs <- function(info, ...) {

  if(session_include_pkgs_df(info)) {
    result <- tibble::data_frame(
      package = info$package,
      version = info$ondiskversion,
      attached = info$attached
    )
  } else {
    result <- session_pkgs_to_df(info, ...)

    result <- result[, c("package", "version", "attached")]
  }

  return(result)
}
