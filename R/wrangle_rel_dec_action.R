#' @title Wrangle Decisions Related to Actions
#'
#' @description Wrangles an input `rel_dec_action` data frame and prepares
#'   it for use by the the reporting functions in this package.
#'
#' @export
#' @param db_rel_dec_action  data frame; A standard `rel_dec_action`
#'                           data frame.
#'
#' @return A formatted data frame suitable for use by the report functions.
#'
#' @examples
#' # Get test data
#' db_rel_dec_action <- rarr::db_rel_dec_action
#'
#' rel_dec_action <- wrangle_rel_dec_action(db_rel_dec_action)
#'
#'
#' @importFrom dplyr filter relocate
#' @importFrom rlang .data
#'
wrangle_rel_dec_action <- function(db_rel_dec_action) {
  # Check parameters
  if(!is.data.frame(db_rel_dec_action)) {
    stop("db_rel_dec_action must be a data frame")}

  # Remove test records
  rel_dec_action <- rarr::remove_test_records(db_rel_dec_action, "DECISION_NO")
  rel_dec_action <- rarr::remove_test_records(rel_dec_action, "ACTION_NO")

  # Cleanup id numbers for sorting
  rel_dec_action <- rarr::format_id(rel_dec_action, "DECISION_NO")
  rel_dec_action <- rarr::format_id(rel_dec_action, "ACTION_NO")

  # Create hyperlinks
  rel_dec_action <- rarr::id_link(rel_dec_action, "decision_no")
  rel_dec_action <- rarr::id_link(rel_dec_action, "action_no")

  rel_dec_action <- rel_dec_action %>%
    # Filter for "Active" records
    filter(.data$DECISION_ACTIVE == "Yes" & .data$ACTION_ACTIVE == "Yes") %>%

    # Reorder fields
    relocate(.data$ACTION_ACTIVE, .after = .data$action_no_link)

  return(rel_dec_action)
}
