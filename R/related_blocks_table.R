#' @title Related Blocks Table
#'
#' @description Creates a table of items within related blocks.
#'
#' @param related_blocks   data frame; A `related_blocks` data frame.
#'
#' @return A kable table of related block items
#' @export
#'
#' @examples
#' # Get test data
#' db_risk <- rarr::db_risk
#' db_action <- rarr::db_action
#' db_decision <- rarr::db_decision
#'
#' #Wrangle test data
#' risk <- rarr::wrangle_risk(db_risk)
#' action <- rarr::wrangle_action(db_action)
#' decision <- rarr::wrangle_decision(db_decision)
#' items<-rarr::create_items(risk, action, decision)
#'
#' # Get test data
#' db_rel_action_action <- rarr::db_rel_action_action
#' db_rel_dec_dec<- rarr::db_rel_dec_dec
#' db_rel_dec_action<- rarr::db_rel_dec_action
#' db_rel_risk_action <- rarr::db_rel_risk_action
#' db_rel_risk_dec <- rarr::db_rel_risk_dec
#' db_rel_risk_risk <- rarr::db_rel_risk_risk
#'
#' # Wrangle data
#' rel_action_action <- rarr::wrangle_rel_action_action(db_rel_action_action)
#' rel_dec_dec <- rarr::wrangle_rel_dec_dec(db_rel_dec_dec)
#' rel_dec_action <- rarr::wrangle_rel_dec_action(db_rel_dec_action)
#' rel_risk_action <- rarr::wrangle_rel_risk_action(db_rel_risk_action)
#' rel_risk_dec <- rarr::wrangle_rel_risk_dec(db_rel_risk_dec)
#' rel_risk_risk <- rarr::wrangle_rel_risk_risk(db_rel_risk_risk)
#'
#' relations<-rarr::create_relations(rel_action_action, rel_dec_action, rel_dec_dec,
#' rel_risk_action,rel_risk_dec,rel_risk_risk)
#'
#' relate_igraph<- igraph::graph_from_data_frame(d = relations,vertices = items,
#' directed = FALSE)
#'
#' related_blocks<-rarr::network_analysis(relate_igraph, items)
#'
#' #example
#' block_table<-rarr::related_blocks_table(related_blocks)
#'
#'
#' @importFrom magrittr %>%
#' @importFrom kableExtra kable_styling kbl pack_rows column_spec
#' @importFrom dplyr select
#' @importFrom rlang .data
#'
#'
related_blocks_table <- function(related_blocks) {
  related_blocks_df <- related_blocks %>%
    select(.data$item_link, .data$description, .data$adj_count)

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
