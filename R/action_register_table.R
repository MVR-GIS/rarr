#' @title Action Register Table
#'
#' @description Produces an action register table of the input action
#'   data frame.
#'
#' @param action   data frame; A data frame of actions.
#'
#' @examples
#' #Get test data
#' db_action <- rarr::db_action
#'
#' action <- wrangle_action(db_action)
#'
#' #example
#' action_register<- action_register_table(action)
#'
#' @return A kable table styled for reporting.
#' @export
#' @importFrom dplyr select mutate
#' @importFrom kableExtra kbl kable_styling column_spec
#' @importFrom magrittr %>%
#' @importFrom lubridate as_date
#'
action_register_table <- function(action) {
  action_df <- action %>%
    select(.data$action_no_link, .data$ACTION, .data$start_date, .data$end_date) %>%
    mutate(start_date = as_date(.data$start_date),
           end_date = as_date(.data$end_date))

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
