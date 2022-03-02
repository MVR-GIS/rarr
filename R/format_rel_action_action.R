#' @title Format Actions Related to other Actions
#'
#' @description Formats an input `rel_action_action` data frame and prepares
#'   it for use by the the reporting functions in this package.
#'
#' @export
#' @param db_rel_action_action   data frame; A standard `rel_action_action`
#'                               data frame.
#'
#' @return A formatted data frame suitable for use by the report functions.
#'
#' @examples
#' # Get test data
#' db_rel_action_action <- rarr::db_rel_action_action
#'
#' # Format rel_action_action
#' rel_action_action <- format_rel_action_action(db_rel_action_action)
#'
#' @importFrom dplyr relocate
#' @importFrom rlang .data
#'
format_rel_action_action <- function(db_rel_action_action) {
  # Check parameters
  if(!is.data.frame(db_rel_action_action)) {
    stop("db_rel_action_action must be a data frame")}

  # Remove test records
  rel_action_action <- rarr::remove_test_records(db_rel_action_action,
                                                 "ACTION_NO")
  rel_action_action <- rarr::remove_test_records(rel_action_action,
                                                 "RELATED_ACTION")

  # Filter for "Active" records
  rel_action_action <- rel_action_action %>%
    filter(.data$ACTION_ACTIVE == "Yes" & .data$REL_ACTION_ACTIVE == "Yes")

  # Cleanup id numbers for sorting
  rel_action_action <- rarr::format_id(rel_action_action, "ACTION_NO")
  rel_action_action <- rarr::format_id(rel_action_action, "RELATED_ACTION")

  # Create hyperlink to related item
  rel_action_action <- rarr::id_link(rel_action_action, "related_action")

  # Reorder fields
  rel_action_action <- rel_action_action %>%
    relocate(.data$REL_ACTION_ACTIVE, .after = .data$related_action_link)

}
