#' @title Wrangle Items
#'
#' @return A data frame of all items (risks, actions,decisions)
#'
#' @export
#'
#' @examples
#' # Get test data
#' action<- rarr::db_action
#' action<-rarr::wrangle_action(action)
#' decision<- rarr::db_decision
#' decision <- rarr:: wrangle_decision(decision)
#' risk<- rarr::db_risk
#' risk<-rarr::wrangle_risk(risk)
#'
#' items <- wrangle_items(risk, action, decision)
#' @importFrom dplyr bind_rows select rename
#' @importFrom magrittr %>%
#'

wrangle_items<-function(risk,action,decision){
  if(!is.data.frame(risk)) {
    stop("risk must be a data frame")}
  if(!is.data.frame(action)) {
    stop("action must be a data frame")}
  if(!is.data.frame(decision)) {
    stop("decision must be a data frame")}

  risk_items <-risk %>%
    select(risk_no, risk_no_link, CONCERNS, id_type,
           FEATURE, DISCIPLINE) %>%
    rename(item_id = risk_no,
           item_link = risk_no_link,
           description = CONCERNS)

  action_items <- action %>%
    select(action_no, action_no_link, ACTION, id_type,
           FEATURE, DISCIPLINE) %>%
    rename(item_id = action_no,
           item_link = action_no_link,
           description = ACTION)

  decision_items <- decision %>%
    select(decision_no, decision_no_link, DECISION, id_type,
           FEATURE, DISCIPLINE) %>%
    rename(item_id = decision_no,
           item_link = decision_no_link,
           description = DECISION)

  items <- bind_rows(risk_items, action_items, decision_items)

  return(items)
}
