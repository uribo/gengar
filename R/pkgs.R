#' @export
session_pkgs <- function(info, ...) {

  result <- session_pkgs_to_df(info, ...)

  result <- result[, c("package", "version", "required")]

  return(result)
}
