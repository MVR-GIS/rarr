#' @title Engagement Level History Table
#'
#' @description Produces an engagement level history table of the input events
#'   data frame.
#'
#' @param events_df  data frame; An events data frame
#' @param items      character; A character vector of item identifiers
#' @param show_link  logical; Show item link and group the table by item type.
#'
#' @return A kable table styled for reporting.
#' @export
#'
eng_level_history <- function(events_df, items, show_item_link = TRUE) {
  # Pre-process the data
  events_level <- events_df %>%
    mutate(id_type = str_to_title(id_type)) %>%
    mutate(level_date = as_date(level_date)) %>%
    filter(fk_table_id %in% items)

  if(show_item_link) {
    evnts <- select(events_level,
                    fk_table_id_link, ENG_LEVEL, level_date,
                    DESCRIPTION, duration_days)
    col_names <- c("Item", "Level", "Date",
                   "Reason for level change", "Duration (days)")
  }
  if(!show_item_link) {
    evnts <- select(events_level,
                    ENG_LEVEL, level_date,
                    DESCRIPTION, duration_days)
    col_names <- c("Level", "Date",
                   "Reason for level change", "Duration (days)")
  }

  # Build the table
  eng_level_table <- kbl(evnts,
                         col.names = col_names) %>%
    kable_styling(bootstrap_options = c("striped", "hover", "condensed",
                                        "responsive"),
                  full_width = TRUE,
                  position = "left",
                  font_size = 12)

  # Conditionally style the table
  if(show_item_link) {
    eng_level_table %>%
      column_spec(1, width = "8em") %>%
      column_spec(2, width = "8em") %>%
      column_spec(3, width = "8em")
  }

  if(!show_item_link) {
    eng_level_table %>%
      pack_rows(index = table(events_level$id_type),
                indent = FALSE,
                label_row_css = "background-color: #dad8d8; color: #000000;") %>%
      column_spec(1, width = "8em") %>%
      column_spec(2, width = "8em") %>%
      column_spec(3, width = "8em")
  }

  return(eng_level_table)
}
