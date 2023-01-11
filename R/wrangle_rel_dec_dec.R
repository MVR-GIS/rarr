#' @title Wrangle Decisions Related to other Decisions
#'
#' @description Wrangles an input `rel_dec_dec` data frame and prepares
#'   it for use by the the reporting functions in this package.
#'
#' @export
#' @param db_rel_dec_dec   data frame; A standard `rel_dec_dec` data frame.
#'
#' @return A formatted data frame suitable for use by the report functions.
#'
#' @examples
#' # Get test data
#' db_rel_dec_dec <- rarr::db_rel_dec_dec
#'
#' # Wrangle rel_dec_dec
#' rel_dec_dec <- wrangle_rel_dec_dec(db_rel_dec_dec)
#'
#' @importFrom dplyr filter relocate
#' @importFrom rlang .data
#' @importFrom magrittr %>%
#'
wrangle_rel_dec_dec <- function(db_rel_dec_dec) {
  # Check parameters
  if(!is.data.frame(db_rel_dec_dec)) {
    stop("db_rel_dec_dec must be a data frame")}

  # Remove test records
  rel_dec_dec <- rarr::remove_test_records(db_rel_dec_dec, "DECISION_NO")
  rel_dec_dec <- rarr::remove_test_records(rel_dec_dec, "RELATED_DECISION")

  # Cleanup id numbers for sorting
  rel_dec_dec <- rarr::format_id(rel_dec_dec, "DECISION_NO")
  rel_dec_dec <- rarr::format_id(rel_dec_dec, "RELATED_DECISION")

  # Create hyperlink to related item
  rel_dec_dec <- rarr::id_link(rel_dec_dec, "related_decision")

  rel_dec_dec <- rel_dec_dec %>%
    # Filter for "Active" records
    filter(.data$DECISION_ACTIVE == "Yes" & .data$REL_DEC_ACTIVE == "Yes") %>%

    # Reorder fields
    relocate(.data$REL_DEC_ACTIVE, .after = .data$related_decision_link)

  return(rel_dec_dec)
}
