#' @title Wrangle Items
#'
#' @return A data frame of all items (risks, actions,decisions)
#'
#' @param risk  data frame; A risk data frame
#' @param action      data frame; An action data frame
#' @param decision  data frame; A decision data frame
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
    select(.data$risk_no, .data$risk_no_link, .data$CONCERNS, .data$id_type,
           .data$FEATURE, .data$DISCIPLINE) %>%
    rename(item_id = .data$risk_no,
           item_link = .data$risk_no_link,
           description = .data$CONCERNS)

  action_items <- action %>%
    select(.data$action_no, .data$action_no_link, .data$ACTION, .data$id_type,
           .data$FEATURE, .data$DISCIPLINE) %>%
    rename(item_id = .data$action_no,
           item_link = .data$action_no_link,
           description = .data$ACTION)

  decision_items <- decision %>%
    select(.data$decision_no, .data$decision_no_link, .data$DECISION, .data$id_type,
           .data$FEATURE, .data$DISCIPLINE) %>%
    rename(item_id = .data$decision_no,
           item_link = .data$decision_no_link,
           description = .data$DECISION)

  items <- bind_rows(risk_items, action_items, decision_items)

  return(items)
}
