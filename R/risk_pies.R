#' @title Risk Pie Charts
#'
#' @description Creates pie charts of risk assessments.
#'
#' @export
#' @param risk_df     data.frame; A data frame of risks.
#'
#' @return silently returns a plot object
#'
#' @examples
#' # Get test data
#' db_risk <- rarr::db_risk
#'
#' #Wrangle test data
#' risk <- rarr::wrangle_risk(db_risk)
#'
#' #example
#' risk_pies(risk)
#'
#' @importFrom dplyr group_by summarize mutate arrange recode
#' @importFrom tidyr drop_na
#' @importFrom magrittr %>%
#' @importFrom graphics par pie title
#' @importFrom stats end
#' @importFrom rlang .data
#'
risk_pies <- function(risk_df) {
  efficacy_risk_count <- risk_df %>%
    group_by(.data$EFFICACY_RISK) %>%
    summarize(count = n(), color = unique(.data$efficacy_risk_color)) %>%
    drop_na(.data$EFFICACY_RISK) %>%
    mutate(percent = round(count/sum(count)*100)) %>%
    mutate(color = recode(.data$color, green = "forestgreen")) %>%
    arrange(factor(.data$EFFICACY_RISK, levels = c("High", "Moderate", "Low")))

  cost_risk_count <- risk_df %>%
    group_by(.data$COST_RISK) %>%
    summarize(count = n(), color = unique(.data$cost_risk_color)) %>%
    drop_na(.data$COST_RISK) %>%
    mutate(percent = round(count/sum(count)*100)) %>%
    mutate(color = recode(.data$color, green = "forestgreen")) %>%
    arrange(factor(.data$COST_RISK, levels = c("High", "Moderate", "Low")))

  schedule_risk_count <- risk_df %>%
    group_by(.data$SCHEDULE_RISK) %>%
    summarize(count = n(), color = unique(.data$schedule_risk_color)) %>%
    drop_na(.data$SCHEDULE_RISK) %>%
    mutate(percent = round(count/sum(count)*100)) %>%
    mutate(color = recode(.data$color, green = "forestgreen")) %>%
    arrange(factor(.data$SCHEDULE_RISK, levels = c("High", "Moderate", "Low")))

  par(mfrow = c(1,3),
      mar = c(0, 0, 1, 0),
      oma = c(0, 0, 0, 0))
  pie(efficacy_risk_count$count,
      labels = paste(efficacy_risk_count$percent, "%"),
      col = efficacy_risk_count$color,
      border = "white",
      clockwise = TRUE,
      main = "Efficacy")

  pie(cost_risk_count$count,
      labels = paste(cost_risk_count$percent, "%"),
      col = cost_risk_count$color,
      border = "white",
      clockwise = TRUE,
      main = "Cost")

  pie(schedule_risk_count$count,
      labels = paste(schedule_risk_count$percent, "%"),
      col = schedule_risk_count$color,
      border = "white",
      clockwise = TRUE,
      main = "Schedule")
}
