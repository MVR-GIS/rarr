#' @title Engagement Level History Table
#'
#' @description Produces an engagement level history table of the input events
#'   data frame.
#'
#' @param events  data frame; An events data frame
#' @param items      character; A character vector of item identifiers
#' @param show_item_link  logical; Show item link and group the table by item type.
#'
#' @return A kable table styled for reporting.
#' @export
#'
#'
#' @examples
#' # Get test data
#' db_events <- rarr::db_events
#' library(magrittr)
#'
#' events <- wrangle_events(db_events)
#' x <- "CA-003"
#'
#' events <- events %>%
#'   dplyr::filter(TABLE_NAME == "RISK_REGISTER") %>%
#'   dplyr::filter(fk_table_id == x)
#'
#' #Example
#' eng_level_table <- eng_level_history(events, events$fk_table_id,
#' show_item_link = TRUE)
#'
#' @importFrom dplyr mutate filter select
#' @importFrom stringr str_to_title
#' @importFrom lubridate as_date
#' @importFrom rlang .data
#' @importFrom kableExtra kbl kable_styling column_spec pack_rows
#' @importFrom magrittr %>%
#'
#'
#'
eng_level_history <-
  function(events, items, show_item_link = TRUE) {
    # Pre-process the data
    events_level <- events %>%
      dplyr::mutate(id_type = str_to_title(.data$id_type)) %>%
      dplyr::mutate(level_date = as_date(.data$level_date)) %>%
      dplyr::filter(.data$fk_table_id %in% items)

    if (show_item_link) {
      evnts <- select(
        events_level,
        .data$fk_table_id_link,
        .data$ENG_LEVEL,
        .data$level_date,
        .data$DESCRIPTION,
        .data$duration_days
      )
      col_names <- c("Item",
                     "Level",
                     "Date",
                     "Reason for level change",
                     "Duration (days)")
    }
    if (!show_item_link) {
      evnts <- select(events_level,
                      .data$ENG_LEVEL,
                      .data$level_date,
                      .data$DESCRIPTION,
                      .data$duration_days)
      col_names <- c("Level", "Date",
                     "Reason for level change", "Duration (days)")
    }

    # Build the table
    eng_level_table <- kbl(evnts,
                           col.names = col_names) %>%
      kable_styling(
        bootstrap_options = c("striped", "hover", "condensed",
                              "responsive"),
        full_width = TRUE,
        position = "left",
        font_size = 12
      )

    # Conditionally style the table
    if (show_item_link) {
      eng_level_table %>%
        column_spec(1, width = "8em") %>%
        column_spec(2, width = "8em") %>%
        column_spec(3, width = "8em")
    }

    if (!show_item_link) {
      eng_level_table %>%
        pack_rows(
          index = table(events_level$id_type),
          indent = FALSE,
          label_row_css = "background-color: #dad8d8; color: #000000;"
        ) %>%
        column_spec(1, width = "8em") %>%
        column_spec(2, width = "8em") %>%
        column_spec(3, width = "8em")
    }

    return(eng_level_table)
  }
