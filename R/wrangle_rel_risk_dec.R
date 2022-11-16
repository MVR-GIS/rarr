#' @title Wrangle Rel Risk Decisions
#'
#' @description Wrangles an input `rel_risk_dec` data frame and prepares
#'   it for use by the the reporting functions in this package.
#'
#' @export
#' @param db_rel_risk_dec   data frame; A standard `rel_risk_dec` data frame.
#'
#' @return A formatted data frame suitable for use by the report functions.
#'
#' @examples
#' # Get test data
#' db_rel_risk_dec <- rarr::db_rel_risk_dec
#'
#' # Format rel_risk_dec
#' rel_risk_dec <- wrangle_rel_risk_dec(db_rel_risk_dec)
#'
#' @importFrom dplyr filter relocate
#' @importFrom rlang .data
#'
#'
wrangle_rel_risk_dec<- function(db_rel_risk_dec, active = TRUE) {
  # Check parameters
  if(!is.data.frame(db_rel_risk_dec)) {
    stop("db_rel_risk_dec must be a data frame")}

  # Remove test records
 risk<- rarr::remove_test_records(db_rel_risk_dec, "RISK_NO")
 risk<- rarr::remove_test_records(risk, "DECISION_NO")

  # Filter for "Active" records
 risk <- risk %>%
   filter(RISK_ACTIVE == "Yes" & DECISION_ACTIVE =="Yes")

  # Cleanup id fields for sorting
 risk <- rarr::format_id(risk, "RISK_NO")
 risk <- rarr::format_id(risk, "DECISION_NO")

  # Create hyperlink
 risk <- rarr::id_link(risk, "risk_no")
 risk <- rarr::id_link(risk, "decision_no")

  # Reorder fields
 rel_risk_dec <- risk %>%
   relocate(DECISION_ACTIVE, .after = decision_no_link)

 return(rel_risk_dec)
}
