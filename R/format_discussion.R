#' @title Format Discussion
#'
#' @description Formats an input discussion data frame and prepares it for use
#'   by the the reporting functions in this package.
#'
#' @export
#' @param db_discussion data frame; A standard discussion data frame.
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
format_discussion <- function(db_discussion) {
  # Check inputs
  if(!is.data.frame(db_discussion)) {
    stop("db_discussion must be a data frame")}

  # Remove test records
  discussion <- rarr::remove_test_records(db_discussion, "FK_TABLE_ID")

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
    relocate(.data$fk_table_id, .after = .data$FK_TABLE_ID) %>%
    relocate(.data$RESPONSIBLE_POC, .after = .data$DISCUSSION) %>%
    relocate(.data$poc_review_date, .after = .data$RESPONSIBLE_POC)

  return(discussion)
}
