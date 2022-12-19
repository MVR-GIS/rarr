#' @title Wrangle Risk Time Risk Category for Timeline
#'
#' @description Wrangles an input risk data frame into a risk_time_riskcategory
#' data frame for rarr:timeline function.
#'
#' @export
#' @param risk   data frame; A standard risk table.
#'
#' @return A formatted data frame suitable for use by rarr's timeline function.
#'
#' @examples
#' # Get test data
#' db_risk <- rarr::db_risk
#'
#' # Wrangle risk data
#' risk<- rarr::wrangle_risk(db_risk)
#'
#' # Wrangle risk time riskcategory
#' risk_time_riskcategory <- wrangle_risk_time_riskcat(risk)
#'
#' @importFrom dplyr rename mutate select relocate
#'                   arrange distinct
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#'
#'
wrangle_risk_time_riskcat <-function(risk) {
  if(!is.data.frame(risk)) {
    stop("db_risk must be a data frame")}
  risk_time_riskcategory<-risk %>%
    select(risk_cat_code, RISKCATEGORY) %>%
    mutate(id = as.numeric(factor(risk_cat_code))) %>%
    rename(content = risk_cat_code) %>%
    rename(title = RISKCATEGORY) %>%
    relocate(id, .before = content) %>%
    distinct(id, content, .keep_all = TRUE)
  return(risk_time_riskcategory)
}
