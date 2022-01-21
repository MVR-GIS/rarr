#' @title Convert Date Field
#'
#' @description Converts character date fields to POSIXct format. Converts
#'   any field name ending in "_DATE" to POSIXct.
#'
#' @export
#'
#' @param df           data frame; A data frame with characrer date fields
#'                       to be converted from character to POSIXct.
#'
#' @return A data frame containing POSIXct date fields.
#'
#' @examples
#' # Get test data
#' risk_oracle <- readr::read_csv(system.file("extdata", "RISK_MAIN_VIEW.csv",
#'                                            package = "rarr"),
#'                                show_col_types = FALSE)
#'
#' # Convert date character fields
#' risk <- convert_date(risk_oracle)
#'
#' @importFrom dplyr mutate across ends_with
#' @importFrom lubridate dmy_hms
#'
convert_date <- function(df) {
  # Check inputs
  if(!is.data.frame(df)) {stop("df must be a data frame")}

  df <- df %>%
    mutate(across(ends_with("_DATE"), lubridate::dmy_hms))

  return(df)
}
