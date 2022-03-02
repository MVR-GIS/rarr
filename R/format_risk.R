#' @title Format Risk
#'
#' @description Formats an input risk data frame and prepares it for use
#'   by the the reporting functions in this package.
#'
#' @export
#' @param risk_table   data frame; A standard risk table.
#' @param active       logical; Return only active records? TRUE returns active
#'                     records, FALSE returns inactive records. Default = TRUE.
#'
#' @return A formatted data frame suitable for use by the report functions.
#'
#' @examples
#' # Get test data
#' db_risk <- rarr::db_risk
#'
#' # Format risk
#' risk <- format_risk(db_risk)
#'
#' @importFrom dplyr filter rename_with ends_with rename mutate select relocate
#'                   arrange distinct desc
#' @importFrom stringr str_to_lower str_to_title str_extract
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#'
format_risk <- function(risk_table, active = TRUE) {
  # Check inputs
  if(!is.data.frame(risk_table)) {stop("risk_table must be a data frame")}
  if(is.logical(active) == FALSE) {stop("active must be logical")}

  # Remove test data
  risk <- rarr::remove_test_records(risk_table, "RISK_NO")

  # Filter for active records
  risk <- rarr::remove_inactive_records(risk, active = TRUE)

  risk <- risk %>%
    # Rename date fields
    rename_with(.fn = str_to_lower,
                .cols = ends_with("_date")) %>%

    # Process assessment fields
    rename(cost_risk_color     = CONDITIONAL_FORMATTING,
           schedule_risk_color = CONDITIONAL_FORMATTING2,
           efficacy_risk_color = CONDITIONAL_FORMATTING3) %>%
    mutate(cost_risk_color     = str_to_lower(.data$cost_risk_color),
           schedule_risk_color = str_to_lower(.data$schedule_risk_color),
           efficacy_risk_color = str_to_lower(.data$efficacy_risk_color)) %>%

    # Set engagement level integer, risk_cat_code
    mutate(eng_level = as.numeric(str_extract(ENG_LEVEL, "\\d")),
           risk_cat_code = str_extract(RISK_NO, "\\w+\\b")) %>%

    # Add efficacy_impact_per_project (not applicable, so set blank)
    mutate(EFFICACY_IMPACT_PER_PROJECT = "") %>%

    # Convert factor variables to title case for labeling
    mutate(RISKCATEGORY = str_to_title(str_to_lower(RISKCATEGORY)))

  # Cleanup risk number for sorting
  risk <- rarr::format_id(risk, "RISK_NO")

  # Create hyperlink to risk_no
  risk <- rarr::id_link(risk, "risk_no")

  risk <- risk %>%
    # Remove unused fields
    select(!c(PDT_DISC_CONC, PDT_DISC_LIKELI_IMPACT,
              PDT_DISC_RISK_MANAG_STRATEGY, ACTION_ITEMS, LESSONS_LEARNED,
              FK_TABLE_ID)) %>%

    # Reorder fields
    relocate(risk_no, .after = RISK_NO) %>%
    relocate(risk_no_link, .after = .data$risk_no) %>%
    relocate(CONCERNS, .after = .data$risk_no_link) %>%
    relocate(COST_RISK, .after = COST_IMPACT_PER_PROJECT) %>%
    relocate(cost_risk_color,  .after = COST_RISK) %>%
    relocate(SCHEDULE_RISK, .after = SCHEDULE_IMPACT_PER_PROJECT) %>%
    relocate(schedule_risk_color, .after = SCHEDULE_RISK) %>%
    relocate(EFFICACY_IMPACT, .after = EFFICACY_LIKELIHOOD) %>%
    relocate(EFFICACY_IMPACT_PER_PROJECT, .after = EFFICACY_IMPACT) %>%
    relocate(efficacy_risk_color, .after = EFFICACY_RISK) %>%
    relocate(TIMING_OF_DELAY, .after = RISK_STRATEGY) %>%
    relocate(start_date, .after = CONCERNS) %>%
    relocate(end_date, .after = .data$start_date) %>%
    relocate(poc_review_date, .after = TECHNICAL_POC) %>%
    relocate(eng_level, .after = ENG_LEVEL) %>%
    relocate(risk_cat_code, .after = RISKCATEGORY) %>%

    # Sort and Remove duplicates
    arrange(risk_no, desc(.data$level_date)) %>%      # get the latest level
    distinct(risk_no, .keep_all = TRUE)

  return(risk)
}
