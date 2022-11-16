#' @title Wrangle Rel Risk Decisions
#'
#' @description Formats an input `rel_risk_dec` data frame and prepares
#'   it for use by the the reporting functions in this package.
#'
#' @export
#' @param db_rel_dec_dec   data frame; A standard `rel_dec_dec` data frame.
#'
#' @return A formatted data frame suitable for use by the report functions.
#'
#' @examples
#' # Get test data
#' rel_risk_dec <- rarr::db_rel_dec_dec
#'
#' # Format rel_risk_dec
#' rel_dec_dec <- format_rel_dec_dec(db_rel_risk_dec)
#'
#' @importFrom dplyr filter relocate
#' @importFrom rlang .data
#'
wrangle_rel_risk_dec<- function(db_rel_risk_dec, active = TRUE) {
 risk<- rarr::remove_test_records(db_rel_risk_dec, "RISK_NO")
 risk<- rarr::remove_test_records(risk, "DECISION_NO")
 risk <- risk %>%
   filter(RISK_ACTIVE == "Yes" & DECISION_ACTIVE =="Yes")
}
# Remove test records
#rel_risk_dec <- remove_test_records(rel_risk_dec_oracle, "RISK_NO")
#rel_risk_dec <- remove_test_records(rel_risk_dec, "DECISION_NO")

# Filter for "Active" records
#rel_risk_dec <- rel_risk_dec %>%
  #filter(RISK_ACTIVE == "Yes" & DECISION_ACTIVE == "Yes")

# Cleanup id fields for sorting
rel_risk_dec <- format_id(rel_risk_dec, "RISK_NO")
rel_risk_dec <- format_id(rel_risk_dec, "DECISION_NO")

# Create hyperlink
rel_risk_dec <- id_link(rel_risk_dec, "risk_no")
rel_risk_dec <- id_link(rel_risk_dec, "decision_no")

# Reorder fields
rel_risk_dec <- rel_risk_dec %>%
  relocate(DECISION_ACTIVE, .after = decision_no_link)

# Cleanup
#rm(rel_risk_dec_oracle)
