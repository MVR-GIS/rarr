#' @title Percent Treemap
#'
#' @description Creates a treemapify ggplot2 object for the input data frame
#'   column. This serves as a replacement for a pie chart.
#'
#' @param df         data frame; a risk data frame to be summarized
#' @param column     unquoted column name to be summarized.
#' @param title      character; Title for the plot.
#'
#' @return A ggplot2 object.
#' @export
#'
#' @importFrom dplyr mutate count
#' @importFrom ggplot2 ggplot theme aes ggtitle scale_fill_brewer
#' @importFrom treemapify geom_treemap geom_treemap_text
#' @importFrom magrittr %>%
#'
#'
#'
percent_treemap <- function(df, column, title) {
  # Enquote the column
  col <- enquo(column)

  # Generate count of records for the specified column
  count_df <- count(df, !!col) %>%
    dplyr::mutate(percent = (n / sum(n)) * 100) %>%
    dplyr::mutate(label = paste0(!!col, " (",
                          round(percent, 1), "%)"))
  p1 <- ggplot(count_df,
               aes(area = n, fill = label, label = label)) +
    geom_treemap() +
    geom_treemap_text(reflow = TRUE, min.size = 5, grow = FALSE) +
    scale_fill_brewer(palette = "Dark2") +
    theme(legend.position = "none") +
    ggtitle(title)
}
