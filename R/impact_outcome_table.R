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
impact_outcome_table <- function(risk_df) {
  # pre-process the data
  impact_outcome <- risk_df %>%
    select(IMPACT, OUTCOME) %>%
    pivot_longer(cols = c("IMPACT", "OUTCOME"),
                 names_to = "type",
                 values_to = "comment") %>%
    mutate(type = str_to_title(type))

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
