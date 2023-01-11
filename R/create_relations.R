#' Create relations
#'
#' @param rel_action_action dataframe
#' @param rel_dec_action dataframe
#' @param rel_dec_dec dataframe
#' @param rel_risk_action dataframe
#' @param rel_risk_dec dataframe
#' @param rel_risk_risk dataframe
#'
#' @return A data frame of all relationships
#' @export
#'
#' @examples
#' # Get test data
#' db_rel_action_action <- rarr::db_rel_action_action
#' db_rel_dec_action <- rarr::db_rel_dec_action
#' db_rel_dec_dec<- rarr::db_rel_dec_dec
#' db_rel_risk_action <- rarr::db_rel_risk_action
#' db_rel_risk_dec <- rarr::db_rel_risk_dec
#' db_rel_risk_risk <- rarr::db_rel_risk_risk
#'
#' # Wrangle data
#' rel_action_action <- rarr::wrangle_rel_action_action(db_rel_action_action)
#' rel_dec_action<-rarr::wrangle_rel_dec_action(db_rel_dec_action)
#' rel_dec_dec <- rarr::wrangle_rel_dec_dec(db_rel_dec_dec)
#' rel_risk_action <- rarr::wrangle_rel_risk_action(db_rel_risk_action)
#' rel_risk_dec <- rarr::wrangle_rel_risk_dec(db_rel_risk_dec)
#' rel_risk_risk <- rarr::wrangle_rel_risk_risk(db_rel_risk_risk)
#' relations<-rarr::create_relations(rel_action_action, rel_dec_action,
#'            rel_dec_dec,rel_risk_action,rel_risk_dec,rel_risk_risk)
#'
#' @importFrom dplyr filter relocate
#' @importFrom rlang .data
#' @importFrom tidyr drop_na
#' @importFrom magrittr %>%
#'

# Create a df of all relationships
create_relations <-
  function(rel_action_action,
           rel_dec_action,
           rel_dec_dec,
           rel_risk_action,
           rel_risk_dec,
           rel_risk_risk) {
    rel_a_a <- rel_action_action %>%
      select(action_no, related_action) %>%
      rename(from = action_no,
             to = related_action) %>%
      mutate(id_type_1 = "action",
             id_type_2 = "action")

    rel_d_a <- rel_dec_action %>%
      select(decision_no, action_no) %>%
      rename(from = decision_no,
             to = action_no) %>%
      mutate(id_type_1 = "decision",
             id_type_2 = "action")

    rel_d_d <- rel_dec_dec %>%
      select(decision_no, related_decision) %>%
      rename(from = decision_no,
             to = related_decision) %>%
      mutate(id_type_1 = "decision",
             id_type_2 = "decision")

    rel_r_a <- rel_risk_action %>%
      select(risk_no, action_no) %>%
      rename(from = risk_no,
             to = action_no) %>%
      mutate(id_type_1 = "risk",
             id_type_2 = "action")

    rel_r_d <- rel_risk_dec %>%
      select(risk_no, decision_no) %>%
      rename(from = risk_no,
             to = decision_no) %>%
      mutate(id_type_1 = "risk",
             id_type_2 = "decision")

    rel_r_r <- rel_risk_risk %>%
      select(risk_no, related_risk) %>%
      rename(from = risk_no,
             to = related_risk) %>%
      mutate(id_type_1 = "risk",
             id_type_2 = "risk")

    relations <-
      bind_rows(rel_a_a, rel_d_a, rel_d_d, rel_r_a, rel_r_d, rel_r_r) %>%
      drop_na()
    return(relations)
  }
