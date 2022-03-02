#' @title Remove Inactive Records
#'
#' @description Removes inactive records from the input data frame. Data frame
#'   must contain an `ACTIVE` field coded with "Yes" or "No".
#'
#' @export
#' @param df       data frame; A standard risk analysis data frame.
#' @param active   logical; Return only active records? TRUE returns active
#'                 records, FALSE returns inactive records. Default = TRUE.
#'
#' @return A data frame with the inactive records removed.
#'
#' @examples
#' # Get test data
#' db_risk <- rarr::db_risk
#'
#' risk_active <- remove_inactive_records(db_risk)
#'
#' @importFrom dplyr filter
#' @importFrom magrittr %>%
#'
remove_inactive_records <- function(df, active = TRUE) {
  # Check inputs
  if(!is.data.frame(df)) {stop("df must be a data frame")}
  if(is.logical(active) == FALSE) {stop("active must be logical")}

  # Convert parameter to match ACTIVE field coding
  active_text <- ifelse(active, "Yes", "No")

  if("ACTIVE" %in% colnames(df)) {
    df <- df %>%
      filter(ACTIVE == active_text)
  }

  return(df)
}
