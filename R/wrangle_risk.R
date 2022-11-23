#' @title Wrangle Risk
#'
#' @description Wrangles an input risk data frame and prepares it for use
#'   by the the reporting functions in this package.
#'
#' @export
#' @param db_risk   data frame; A standard risk table.
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
#' risk <- wrangle_risk(db_risk)
#'
#' @importFrom dplyr filter rename_with ends_with rename mutate select relocate
#'                   arrange distinct desc
#' @importFrom stringr str_to_lower str_to_title str_extract
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#'
wrangle_risk <- function(db_risk, active = TRUE) {
  # Check inputs
  if(!is.data.frame(db_risk)) {stop("db_risk must be a data frame")}
  if(is.logical(active) == FALSE) {stop("active must be logical")}

  # Remove test data
  risk <- rarr::remove_test_records(db_risk, "RISK_NO")

  # Filter for active records
  risk <- rarr::remove_inactive_records(risk, active = TRUE)

  risk <- risk %>%
    # Rename date fields
    rename_with(.fn = str_to_lower,
                .cols = ends_with("_date")) %>%

    # Process assessment fields
    rename(cost_risk_color     = .data$CONDITIONAL_FORMATTING,
           schedule_risk_color = .data$CONDITIONAL_FORMATTING2,
           efficacy_risk_color = .data$CONDITIONAL_FORMATTING3) %>%
    mutate(cost_risk_color     = str_to_lower(.data$cost_risk_color),
           schedule_risk_color = str_to_lower(.data$schedule_risk_color),
           efficacy_risk_color = str_to_lower(.data$efficacy_risk_color)) %>%

    # Set engagement level integer, risk_cat_code
    mutate(eng_level = as.numeric(str_extract(.data$ENG_LEVEL, "\\d")),
           risk_cat_code = str_extract(.data$RISK_NO, "\\w+\\b")) %>%

    # Add efficacy_impact_per_project (not applicable, so set blank)
    mutate(EFFICACY_IMPACT_PER_PROJECT = "") %>%

    # Convert factor variables to title case for labeling
    mutate(RISKCATEGORY = str_to_title(str_to_lower(.data$RISKCATEGORY)))

  # Cleanup risk number for sorting
  risk <- rarr::format_id(risk, "RISK_NO")

  # Create hyperlink to risk_no
  risk <- rarr::id_link(risk, "risk_no")

  risk <- risk %>%
    # Remove unused fields
    select(!c(.data$PDT_DISC_CONC, .data$PDT_DISC_LIKELI_IMPACT,
              .data$PDT_DISC_RISK_MANAG_STRATEGY, .data$ACTION_ITEMS,
              .data$LESSONS_LEARNED, .data$FK_TABLE_ID)) %>%

    # Reorder fields
    relocate(.data$risk_no, .after = .data$RISK_NO) %>%
    relocate(.data$risk_no_link, .after = .data$risk_no) %>%
    relocate(.data$CONCERNS, .after = .data$risk_no_link) %>%
    relocate(.data$COST_RISK, .after = .data$COST_IMPACT_PER_PROJECT) %>%
    relocate(.data$cost_risk_color,  .after = .data$COST_RISK) %>%
    relocate(.data$SCHEDULE_RISK, .after = .data$SCHEDULE_IMPACT_PER_PROJECT) %>%
    relocate(.data$schedule_risk_color, .after = .data$SCHEDULE_RISK) %>%
    relocate(.data$EFFICACY_IMPACT, .after = .data$EFFICACY_LIKELIHOOD) %>%
    relocate(.data$EFFICACY_IMPACT_PER_PROJECT, .after = .data$EFFICACY_IMPACT) %>%
    relocate(.data$efficacy_risk_color, .after = .data$EFFICACY_RISK) %>%
    relocate(.data$TIMING_OF_DELAY, .after = .data$RISK_STRATEGY) %>%
    relocate(.data$start_date, .after = .data$CONCERNS) %>%
    relocate(.data$end_date, .after = .data$start_date) %>%
    relocate(.data$poc_review_date, .after = .data$TECHNICAL_POC) %>%
    relocate(.data$eng_level, .after = .data$ENG_LEVEL) %>%
    relocate(.data$risk_cat_code, .after = .data$RISKCATEGORY) %>%

    # Sort and Remove duplicates
    arrange(.data$risk_no, desc(.data$level_date)) %>%   # get the latest level
    distinct(.data$risk_no, .keep_all = TRUE)

  return(risk)
}
