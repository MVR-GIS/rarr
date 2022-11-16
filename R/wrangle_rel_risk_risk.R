#' @title Wrangle Rel Risk Risk
#'
#' @description Wrangles an input `rel_risk_risk` data frame and prepares
#'   it for use by the the reporting functions in this package.
#'
#' @export
#' @param db_rel_risk_dec   data frame; A standard `rel_risk_risk` data frame.
#'
#' @return A formatted data frame suitable for use by the report functions.
#'
#' @examples
#' # Get test data
#' db_rel_risk_risk <- rarr::db_rel_risk_risk
#'
#' # Format rel_risk_risk
#' rel_risk_risk <- wrangle_rel_risk_risk(db_rel_risk_risk)
#'
#' @importFrom dplyr filter relocate
#' @importFrom rlang .data
#'
#'

wrangle_rel_risk_risk<- function(db_rel_risk_risk, active = TRUE){
  #Check Parameters
  if(!is.data.frame(db_rel_risk_risk)) {
    stop("db_rel_risk_risk must be a data frame")}

  # Remove test records
  risk <- rarr::remove_test_records(db_rel_risk_risk, "RISK_NO")
  risk <- rarr::remove_test_records(risk, "RELATED_RISK")

  # Filter for "Active" records
  risk <- risk %>%
    filter(RISK_ACTIVE == "Yes" & REL_RISK_ACTIVE == "Yes")

  # Cleanup id numbers for sorting
  risk <- rarr::format_id(risk, "RISK_NO")
  risk <- rarr::format_id(risk, "RELATED_RISK")

  # Create hyperlink to Related Risk
  risk <- rarr::id_link(risk, "related_risk")

  # Reorder fields
  rel_risk_risk <- risk %>%
    relocate(REL_RISK_ACTIVE, .after = related_risk_link)

  return(rel_risk_risk)
}







# Cleanup
#rm(rel_risk_risk_oracle)
