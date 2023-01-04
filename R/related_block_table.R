#' @title Related Blocks Table
#'
#' @description Creates a table of items within related blocks.
#'
#' @param related_blocks   data frame; A `related_blocks` data frame.
#'
#' @return A kable table of related block items
#' @export
#'
related_blocks_table <- function(related_blocks) {
  related_blocks_df <- related_blocks %>%
    select(item_link, description, adj_count)

  col_names <- c("Number", "Description", "Related Items")

  # Create the unstyled kable
  block_table <- kbl(related_blocks_df,
                     col.names = col_names) %>%
    kable_styling(bootstrap_options = c("striped", "hover",
                                        "condensed", "responsive"),
                  font_size = 12)

  # Group rows if records exist
  if(length(related_blocks$item_id) >= 1) {
    block_table <- block_table %>%
      pack_rows(index = table(related_blocks$block_no),
                indent = FALSE,
                label_row_css = "background-color: #dad8d8; color: #000000;") %>%
      column_spec(1, width = "6em") %>%
      column_spec(3, width = "8em")
  }

  return(block_table)
}
