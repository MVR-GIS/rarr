#' @title Wrangle Risk Time for Timeline
#'
#' @description Wrangles an input risk data frame to risk_time for use in rarr's
#' timeline function
#'
#' @export
#' @param risk   data frame; A standard risk table.
#'
#' @return A formatted risk_time data frame suitable for use by the
#' timeline function.
#'
#' @examples
#' # Get test data
#' db_risk <- rarr::db_risk
#' risk<- rarr::wrangle_risk(db_risk)
#'
#' # Wrangle risk_time for timeline
#' risk_time <- wrangle_risk_time(risk)
#'
#' @importFrom dplyr rename mutate select relocate arrange
#' @importFrom magrittr %>%
#'
#'

# Create a timevis "data" data frame of risks
wrangle_risk_time<- function(risk){
  risk_time<- risk %>%
  arrange(.data$risk_no) %>%
  select(.data$OBJECTID, .data$risk_no, .data$start_date, .data$end_date, .data$risk_cat_code,
         .data$CONCERNS, .data$FEATURE, .data$TECHNICAL_POC, .data$eng_level) %>%
  rename(id = .data$OBJECTID) %>%
  rename(content = .data$risk_no) %>%
  relocate(.data$id, .before = .data$content) %>%
  rename(start = .data$start_date) %>%
  rename(end = .data$end_date) %>%
  rename(title = .data$CONCERNS) %>%
  relocate(title, .after = .data$content) %>%
  mutate(group = as.numeric(factor(.data$risk_cat_code))) %>%
  relocate(.data$group, .after = end)
return(risk_time)
}



