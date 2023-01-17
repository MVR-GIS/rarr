#' Create Items
#'
#' @param risk data frame; a wrangled risk data frame
#' @param action data frame; a wrangled action data frame
#' @param decision data frame; a wrangled decision data frame
#'
#' @return a dataframe of risk, action, and decision items
#' @export
#'
#' @examples
#' #Get test data
#' db_risk <- rarr::db_risk
#' db_action <- rarr::db_action
#' db_decision <- rarr::db_decision
#'
#' #Wrangle test data
#' risk <- rarr::wrangle_risk(db_risk)
#' action <- rarr::wrangle_action(db_action)
#' decision <- rarr::wrangle_decision(db_decision)
#'
#' #Create items
#' items<-create_items(risk, action,decision)
#'
#' @importFrom dplyr select rename bind_rows
#' @importFrom magrittr %>%
#'
create_items <- function(risk, action, decision) {
  risk_items <- risk %>%
    select(.data$risk_no, .data$risk_no_link, .data$CONCERNS, .data$id_type,
           .data$FEATURE, .data$DISCIPLINE) %>%
    rename(item_id = .data$risk_no,
           item_link = .data$risk_no_link,
           description = .data$CONCERNS)

  action_items <- action %>%
    select(.data$action_no,
           .data$action_no_link,
           .data$ACTION,
           .data$id_type,
           .data$FEATURE,
           .data$DISCIPLINE) %>%
    rename(item_id = .data$action_no,
           item_link = .data$action_no_link,
           description = .data$ACTION)

  decision_items <- decision %>%
    select(.data$decision_no,
           .data$decision_no_link,
           .data$DECISION,
           .data$id_type,
           .data$FEATURE,
           .data$DISCIPLINE) %>%
    rename(item_id = .data$decision_no,
           item_link = .data$decision_no_link,
           description = .data$DECISION)

  items <- bind_rows(risk_items, action_items, decision_items)
  return(items)
}
