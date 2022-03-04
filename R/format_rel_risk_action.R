#' @title Format Risks Related to Actions
#'
#' @description Formats an input `rel_risk_action` data frame and prepares
#'   it for use by the the reporting functions in this package.
#'
#' @export
#' @param db_rel_risk_action   data frame; A standard `rel_risk_action`
#'                             data frame.
#'
#' @return
#'
#' @examples
format_rel_risk_action <- function(db_rel_risk_action) {
  # Check parameters
  if(!is.data.frame(db_rel_risk_action)) {
    stop("db_rel_dec_dec must be a data frame")}

  # Remove test records
  rel_risk_action <- remove_test_records(rel_risk_action_oracle, "RISK_NO")
  rel_risk_action <- remove_test_records(rel_risk_action, "ACTION_NO")

  # Filter for "Active" records
  rel_risk_action <- rel_risk_action %>%
    filter(RISK_ACTIVE == "Yes" & ACTION_ACTIVE == "Yes")

  # Cleanup id fields for sorting
  rel_risk_action <- format_id(rel_risk_action, "RISK_NO")
  rel_risk_action <- format_id(rel_risk_action, "ACTION_NO")

  # Create hyperlink
  rel_risk_action <- id_link(rel_risk_action, "risk_no")
  rel_risk_action <- id_link(rel_risk_action, "action_no")

  # Reorder fields
  rel_risk_action <- rel_risk_action %>%
    relocate(ACTION_ACTIVE, .after = action_no_link)
}
