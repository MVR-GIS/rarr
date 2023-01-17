#' @title Impact and Outcome Table
#'
#' @description Creates a table of risk impact and outcome statements from the
#' input risk data frame.
#'
#' @param risk_df           data.frame; A data frame containing one risk item.
#'
#' @return A kable table styled for reporting.
#' @export
#'
#' @examples
#' # Get test data
#' db_risk <- rarr::db_risk
#'
#' # Wrangle risk data
#' risk <- rarr::wrangle_risk(db_risk)
#'
#' #example
#' impact_outcome_table<-create_impact_outcome_table(risk)
#'
#' @importFrom dplyr mutate select
#' @importFrom tidyr pivot_longer
#' @importFrom kableExtra kable_styling kbl column_spec
#' @importFrom stringr str_to_title
#' @importFrom magrittr %>%
#'
#'
create_impact_outcome_table <- function(risk_df) {
  # pre-process the data
  impact_outcome <- risk_df %>%
    select(.data$IMPACT, .data$OUTCOME) %>%
    pivot_longer(cols = c("IMPACT", "OUTCOME"),
                 names_to = "type",
                 values_to = "comment") %>%
    mutate(type = str_to_title(.data$type))

  # Replace any NA values with ""
  impact_outcome[is.na(impact_outcome)] <- ""

  # Build the table
  impact_outcome_table <- kbl(impact_outcome,
                              col.names = NULL) %>%
    kable_styling(bootstrap_options = c("hover", "condensed",
                                        "responsive"),
                  full_width = TRUE,
                  position = "left",
                  font_size = 12) %>%
    column_spec(1, bold = TRUE, border_right = TRUE)

  return(impact_outcome_table)
}
