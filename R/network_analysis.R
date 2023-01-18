#' Network analysis
#'
#' @param relate_igraph list; used for network analysis
#' @param items data frame; a dataframe of risk, action, and decision items
#'
#' @return A "related blocks" data frame to be used to create related blocks
#' table
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
#'
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
#' relate_igraph <- igraph::graph_from_data_frame(d = relations,
#' vertices = items, directed = FALSE)
#'
#' related_blocks<-rarr::network_analysis(relate_igraph, items)
#'
#' @importFrom igraph graph_from_data_frame degree simplify cohesive_blocks
#' as_adj_list V as_ids
#' @importFrom forcats as_factor
#' @importFrom dplyr left_join arrange relocate select mutate group_by summarise
#' bind_rows n desc rename
#' @importFrom utils stack
#' @importFrom rlang .data
#' @importFrom magrittr %>%
#'
network_analysis <- function(relate_igraph, items) {
  # Set vertex colors and size
  clr <- as_factor(V(relate_igraph)$id_type)
  levels(clr) <- c("#D55E00", "#E69F00", "#0072B2")
  igraph::V(relate_igraph)$color <- as.character(clr)
  igraph::V(relate_igraph)$size  <-
    igraph::degree(relate_igraph) * 5

  # Identify blocks of related items
  relate_igraph_simp <- igraph::simplify(relate_igraph,
                                         remove.multiple = TRUE,
                                         remove.loops = TRUE)
  itemBlocks <- igraph::cohesive_blocks(relate_igraph_simp)

  # Extract of items within each block
  blocks_df <- as.data.frame(t(sapply(itemBlocks$blocks, as_ids)))

  block_list <- list()

  for (i in 2:length(colnames(blocks_df))) {
    block_item <- data.frame(block_no = paste("Group", i - 1),
                             item_id = unlist(blocks_df[[i]]))
    block_list[[i]] <- block_item
  }

  blocks <- bind_rows(block_list)

  # Calculate count of related items for each item
  adjacent_items <- igraph::as_adj_list(relate_igraph_simp)
  adj_df <- as.data.frame(t(sapply(adjacent_items, as_ids)))

  adj_list <- list()

  for (i in 1:length(colnames(adj_df))) {
    if (length(adj_df[[i]][[1]]) > 0) {
      adj_item <- data.frame(item_id = colnames(adj_df)[[i]],
                             rel_item_id = adj_df[[i]][[1]])
      adj_list[[i]] <- adj_item
    }
  }

  adj_items <- bind_rows(adj_list)

  adj_count <- adj_items %>%
    group_by(.data$item_id) %>%
    summarise(adj_count = n())

  # Calculate item centrality - degree
  item_degree <- stack(igraph::degree(relate_igraph))
  item_degree <- item_degree %>%
    dplyr::mutate(item_id = as.character(.data$ind)) %>%
    rename(degree = .data$values) %>%
    relocate(.data$item_id, .before = degree) %>%
    select(c(!.data$ind))

  # Join blocks to items to add key attributes
  related_blocks <- blocks %>%
    left_join(item_degree, by = c("item_id" = "item_id")) %>%
    left_join(adj_count, by = c("item_id" = "item_id")) %>%
    left_join(items, by = c("item_id" = "item_id")) %>%
    arrange(.data$block_no, desc(degree))
  return(related_blocks)
}
