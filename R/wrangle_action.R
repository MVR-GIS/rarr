#' @title Wrangle Action
#'
#' @description Wrangle an input action data frame and prepares it for use
#'   by the the reporting functions in this package.
#'
#' @export
#' @param db_action   data frame; A standard action data frame.
#'
#' @return A formatted data frame suitable for use by the report functions.
#'
#' @examples
#' # Get test data
#' db_action <- rarr::db_action
#'
#' # Wrangle risk
#' action <- wrangle_action(db_action)
#'
#' @importFrom dplyr filter rename_with ends_with rename mutate select relocate
#'                   arrange distinct desc
#' @importFrom stringr str_to_lower str_to_title str_extract
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#'
wrangle_action <- function(db_action) {
  # Check parameters
  if(!is.data.frame(db_action)) {stop("db_action must be a data frame")}

  # Remove test records
  action <- rarr::remove_test_records(db_action, "ACTION_NO")

  # Filter for active records
  action <- rarr::remove_inactive_records(action, active = TRUE)

  action <- action %>%
    # Rename date fields
    rename_with(.fn = str_to_lower,
                .cols = ends_with("_date")) %>%

    # Set engagement level integer, risk_cat_code
    mutate(eng_level = as.numeric(str_extract(.data$ENG_LEVEL, "\\d")))

  # Cleanup action number for sorting
  action <- rarr::format_id(action, "ACTION_NO")

  # Create hyperlink
  action <- rarr::id_link(action, "action_no")

  action <- action %>%
    # Remove unused fields
    select(!c(.data$FK_TABLE_ID)) %>%

    # Reorder fields
    relocate(.data$start_date, .after = .data$ACTION) %>%
    relocate(.data$end_date, .after = .data$start_date) %>%
    relocate(.data$poc_review_date, .after = .data$TECHNICAL_POC) %>%
    relocate(.data$eng_level, .after = .data$ENG_LEVEL) %>%

    # Remove duplicates and sort
    distinct(.data$action_no, .keep_all = TRUE) %>%
    arrange(.data$action_no)

  return(action)
}
