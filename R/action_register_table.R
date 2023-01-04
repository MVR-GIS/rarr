#' @title Action Register Table
#'
#' @description Produces an action register table of the input action
#'   data frame.
#'
#' @param action   data frame; A data frame of actions.
#'
#' @return A kable table styled for reporting.
#' @export
#'
action_register_table <- function(action) {
  action_df <- action %>%
    select(action_no_link, ACTION, start_date, end_date) %>%
    mutate(start_date = as_date(start_date),
           end_date = as_date(end_date))

  # Create the unstyled kable
  action_register <- kbl(action_df,
                         col.names = c("Number", "Action", "Start", "End")) %>%
    kable_styling(bootstrap_options = c("striped", "hover",
                                        "condensed", "responsive"),
                  font_size = 12)

  # Group rows if records exist
  if(length(action_df$action_no) >= 1) {
    action_register <- action_register %>%
      column_spec(1, width = "7em") %>%
      column_spec(3, width = "6em") %>%
      column_spec(4, width = "6em")
  }

  return(action_register)
}
