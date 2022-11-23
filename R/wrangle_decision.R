#' @title Wrangle Decision
#'
#' @description Wrangle an input decision data frame and prepares it for use
#'   by the the reporting functions in this package.
#'
#' @export
#' @param db_decision   data frame; A standard decision data frame.
#'
#' @return A formatted data frame suitable for use by the report functions.
#'
#' @examples
#' # Get test data
#' db_decision <- rarr::db_decision
#'
#' # Format decision
#' decision <- wrangle_decision(db_decision)
#'
#' @importFrom dplyr filter rename_with ends_with rename mutate select relocate
#'                   arrange distinct desc
#' @importFrom stringr str_to_lower str_to_title str_extract
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#'
wrangle_decision <- function(db_decision) {
  # Check parameters
  if(!is.data.frame(db_decision)) {stop("db_decision must be a data frame")}

  # Remove test records
  decision <- rarr::remove_test_records(db_decision, "DECISION_NO")

  # Filter for active records
  decision <- rarr::remove_inactive_records(decision, active = TRUE)

  decision <- decision %>%
    # Rename date fields
    rename_with(.fn = str_to_lower,
                .cols = ends_with("_date")) %>%

    # Set engagement level integer, risk_cat_code
    mutate(eng_level = as.numeric(str_extract(.data$ENG_LEVEL, "\\d")))

  # Cleanup action number for sorting
  decision <- rarr::format_id(decision, "DECISION_NO")

  # Create hyperlink
  decision <- rarr::id_link(decision, "decision_no")

  decision <- decision %>%
    # Remove unused fields
    select(!c(.data$FK_TABLE_ID)) %>%

    # Reorder fields
    relocate(.data$decision_date, .after = .data$DECISION) %>%
    relocate(.data$poc_review_date, .after = .data$TECHNICAL_POC) %>%
    relocate(.data$eng_level, .after = .data$ENG_LEVEL) %>%

    # Remove duplicates and sort
    distinct(.data$decision_no, .keep_all = TRUE) %>%
    arrange(.data$decision_no)

  return(decision)
}
