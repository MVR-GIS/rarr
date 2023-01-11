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
    select(risk_no, risk_no_link, CONCERNS, id_type,
           FEATURE, DISCIPLINE) %>%
    rename(item_id = risk_no,
           item_link = risk_no_link,
           description = CONCERNS)

  action_items <- action %>%
    select(action_no,
           action_no_link,
           ACTION,
           id_type,
           FEATURE,
           DISCIPLINE) %>%
    rename(item_id = action_no,
           item_link = action_no_link,
           description = ACTION)

  decision_items <- decision %>%
    select(decision_no,
           decision_no_link,
           DECISION,
           id_type,
           FEATURE,
           DISCIPLINE) %>%
    rename(item_id = decision_no,
           item_link = decision_no_link,
           description = DECISION)

  items <- bind_rows(risk_items, action_items, decision_items)
  return(items)
}
