#' @title Risk Register Table
#'
#' @description    Produces a risk register table of the input risk data frame.
#'
#' @param risk     data.frame; A data frame of risks.
#'
#' @return `knitr::kable` table of risk items.
#'
#' @examples
#' #Get test data
#' db_risk <- rarr::db_risk
#'
#' risk <- wrangle_risk(db_risk)
#'
#' #example
#' risk_register<-rarr::risk_register_table(risk)
#'
#' @importFrom magrittr %>%
#' @importFrom dplyr select
#' @importFrom kableExtra kbl kable_styling pack_rows column_spec
#'
#' @export
#'
risk_register_table <- function(risk) {
  # Select for the needed fields
  risk_df <- risk %>%
    select(risk_no_link, CONCERNS, RISKCATEGORY, RISK_STRATEGY,
           EFFICACY_RISK, efficacy_risk_color,
           COST_RISK, cost_risk_color,
           SCHEDULE_RISK, schedule_risk_color)

  # Create the unstyled kable
  risk_register <- kbl(select(risk_df,
                              risk_no_link, CONCERNS, RISK_STRATEGY,
                              EFFICACY_RISK, COST_RISK, SCHEDULE_RISK),
                       col.names = c("Number", "Description", "Strategy",
                                     "Efficacy", "Cost", "Schedule")) %>%
    kable_styling(bootstrap_options = c("striped", "hover",
                                        "condensed", "responsive"),
                  font_size = 12)

  # Group rows if records exist
  if(length(risk$RISK_NO) >= 1) {
    risk_register <- risk_register %>%
      pack_rows(index = table(risk_df$RISKCATEGORY),
                indent = FALSE,
                label_row_css = "background-color: #dad8d8; color: #000000;") %>%
      column_spec(4, color = "black",
                  background = risk_df$efficacy_risk_color) %>%
      column_spec(5, color = "black",
                  background = risk_df$cost_risk_color) %>%
      column_spec(6, color = "black",
                  background = risk_df$schedule_risk_color)
  }

  return(risk_register)
}
