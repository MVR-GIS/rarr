#' @title Risk Timeline
#'
#' @description Create a `timevis` timeline of project risks.
#'
#' @export
#' @param risk_df     data frame; A `timevis` "data" data frame.
#' @param groups_df   data frame; A `timevis` "groups" data frame.
#' @param start       date, number, or string that can be converted to a date;
#'                    The start date of the timeline.
#' @param end         date, number, or string that can be converted to a date;
#'                    The end date of the timeline.
#' @param height      Fixed height for timeline (in css units).
#'
#' @return A `timevis` created timeline visualization `htmlwidgets` object.
#' @importFrom timevis timevis
#'
timeline <- function(risk_df, groups_df, start, end, height = NULL) {
  # Set css style for timevis items
  item_style <- "font-size: 0.7em; line-height: 0.5; background: #e6ac00; border-color: #c7d1c7;"
  group_style <- "font-weight: bold"

  risk_df <- mutate(risk_df, style = item_style)
  groups_df <- mutate(groups_df, style = group_style)

  # Create the timeline
  t <- timevis::timevis(risk_df,
                        width = "100%",
                        height = height,
                        groups = groups_df,
                        options = list(start = start,
                                       end   = end,
                                       stack = TRUE,
                                       orientation = "top",
                                       margin = 2))
  return(t)
}



