#' @title Wrangle Risks Related to Actions
#'
#' @description Wrangles an input `rel_risk_action` data frame and prepares
#'   it for use by the the reporting functions in this package.
#'
#' @export
#' @param db_rel_risk_action   data frame; A standard `rel_risk_action`
#'                             data frame.
#'
#' @return A formatted data frame suitable for use by the report functions.
#'
#' @examples
#' # Get test data
#' db_rel_risk_action <- rarr::db_rel_risk_action
#'
#' # Format rel_risk_action
#' rel_risk_action <- wrangle_rel_risk_action(db_rel_risk_action)
#'
#' @importFrom dplyr filter relocate
#' @importFrom rlang .data
#'
wrangle_rel_risk_action <- function(db_rel_risk_action) {
  # Check parameters
  if(!is.data.frame(db_rel_risk_action)) {
    stop("db_rel_risk_action must be a data frame")}

  # Remove test records
  rel_risk_action <- rarr::remove_test_records(db_rel_risk_action,
                                               "RISK_NO")
  rel_risk_action <- rarr::remove_test_records(rel_risk_action,
                                               "ACTION_NO")

  # Cleanup id fields for sorting
  rel_risk_action <- rarr::format_id(rel_risk_action, "RISK_NO")
  rel_risk_action <- rarr::format_id(rel_risk_action, "ACTION_NO")

  # Create hyperlink
  rel_risk_action <- rarr::id_link(rel_risk_action, "risk_no")
  rel_risk_action <- rarr::id_link(rel_risk_action, "action_no")

  rel_risk_action <- rel_risk_action %>%
    # Filter for "Active" records
    filter(.data$RISK_ACTIVE == "Yes" & .data$ACTION_ACTIVE == "Yes") %>%

    # Reorder fields
    relocate(.data$ACTION_ACTIVE, .after = .data$action_no_link)

  return(rel_risk_action)
}
