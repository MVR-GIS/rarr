#' @title ATX-Style Markdown Header
#'
#' @description Produces the ATX-style markdown header (i.e., a number of
#'   hashes) for the input header level.
#'
#' @param level    numeric; Integer number of header level.
#'
#' @return String of ATX-style markdown header.
#'
atx_header <- function (level) {
  if(!is.numeric(level)) {stop ("level must be numeric")}
  if(level%%1 != 0) { stop("level must be an integer") }
  if(level == 0) {stop("level cannot be zero")}
  if(level > 5) {stop("level cannot reasonably be greater than five")}

  paste(rep.int("#", level), collapse = "")
}
