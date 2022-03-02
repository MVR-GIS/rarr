#' @title Format Events
#'
#' @description Formats an input events data frame and prepares it for use
#'   by the the reporting functions in this package.
#'
#' @export
#' @param events_table data frame; A standard events table.
#'
#' @return A formatted data frame suitable for use by the report functions.
#'
#' @examples
#' # Get test data
#' db_events <- rarr::db_events
#'
#' events <- format_events(db_events)
#'
#' @importFrom stringr str_extract str_to_lower
#' @importFrom dplyr rename_with ends_with mutate select relocate arrange
#'                   group_by ungroup lead
#' @importFrom lubridate today interval time_length
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#'
format_events <- function(events_table) {
  # Check inputs
  if(!is.data.frame(events_table)) {stop("risk_table must be a data frame")}

  # Remove test records
  events <- rarr::remove_test_records(events_table, "FK_TABLE_ID")

  # Cleanup risk number for sorting
  events <- rarr::format_id(events, "FK_TABLE_ID")

  # Create hyperlink to fk_table_id
  events <- rarr::id_link(events, "fk_table_id")

  events <- events %>%
    # Set engagement level integer field
    mutate(eng_level = as.numeric(str_extract(.data$ENG_LEVEL, "\\d"))) %>%

    # Rename date fields
    rename_with(.fn = str_to_lower,
                .cols = ends_with("_date")) %>%


    # Remove unused fields
    select(!c(.data$CREATED_USER, .data$LAST_EDITED_USER)) %>%

    # Reorder fields
    relocate(.data$fk_table_id, .after = .data$FK_TABLE_ID) %>%
    relocate(.data$fk_table_id_link, .after = .data$fk_table_id) %>%
    relocate(.data$DESCRIPTION, .after = .data$fk_table_id_link) %>%
    relocate(.data$level_date, .after = .data$ENG_LEVEL) %>%
    relocate(.data$eng_level, .after = .data$ENG_LEVEL) %>%

    # Sort
    arrange(.data$TABLE_NAME, .data$fk_table_id, as.Date(.data$level_date)) %>%

    # Calc event duration (days) within item types (risk/action/decision) and
    # items
    group_by(.data$TABLE_NAME, .data$fk_table_id) %>%
    mutate(level_end_date = lead(as.Date(.data$level_date), n = 1,
                                 default = lubridate::today()),
           date_interval = lubridate::interval(as.Date(.data$level_date),
                                               .data$level_end_date),
           duration_days = lubridate::time_length(.data$date_interval,
                                                  unit = "days")) %>%
    ungroup(.data$TABLE_NAME, .data$fk_table_id)

  return(events)
}
