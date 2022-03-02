#' @title Format Discussion
#'
#' @description Formats an input discussion data frame and prepares it for use
#'   by the the reporting functions in this package.
#'
#' @export
#' @param discussion_table data frame; A standard discussion table.
#'
#' @return A formatted data frame suitable for use by the report functions.
#'
#' @examples
#' # Get test data
#' db_discussion <- rarr::db_discussion
#'
#' discussion <- format_discussion(db_discussion)
#'
#' @importFrom dplyr rename_with ends_with select relocate
#' @importFrom stringr str_to_lower
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#'
format_discussion <- function(discussion_table) {
  # Check inputs
  if(!is.data.frame(discussion_table)) {
    stop("discussion_table must be a data frame")}

  # Remove test records
  discussion <- rarr::remove_test_records(discussion_table, "FK_TABLE_ID")

  # Cleanup discussion number for sorting
  discussion <- rarr::format_id(discussion, "FK_TABLE_ID")

  discussion <- discussion %>%
    # Rename date fields
    rename_with(.fn = str_to_lower,
                .cols = ends_with("_date")) %>%

  # Remove unused fields
    select(!c(.data$LOGGED_BY, .data$CREATED_USER, .data$LAST_EDITED_USER,
              .data$ACTIVE)) %>%

  # Reorder fields
    relocate(fk_table_id, .after = .data$FK_TABLE_ID) %>%
    relocate(RESPONSIBLE_POC, .after = .data$DISCUSSION) %>%
    relocate(poc_review_date, .after = .data$RESPONSIBLE_POC)

  return(discussion)
}
