#' @title Wrangle Risk Time for Timeline
#'
#' @description Wrangles an input risk data frame to risk_time for use in rarr's
#' timeline function
#'
#' @export
#' @param db_risk   data frame; A standard risk table.
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
  arrange(risk_no) %>%
  select(OBJECTID, risk_no, start_date, end_date, risk_cat_code,
         CONCERNS, FEATURE, TECHNICAL_POC, eng_level) %>%
  rename(id = OBJECTID) %>%
  rename(content = risk_no) %>%
  relocate(id, .before = content) %>%
  rename(start = start_date) %>%
  rename(end = end_date) %>%
  rename(title = CONCERNS) %>%
  relocate(title, .after = content) %>%
  mutate(group = as.numeric(factor(risk_cat_code))) %>%
  relocate(group, .after = end)
return(risk_time)
}



