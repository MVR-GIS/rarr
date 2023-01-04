# Get test data
db_risk <- rarr::db_risk
db_action <- rarr::db_action
db_decision <- rarr::db_decision

#Wrangle test data
risk <- rarr::wrangle_risk(db_risk)
action <- rarr::wrangle_action(db_action)
decision <- rarr::wrangle_decision(db_decision)

items<-rarr::create_items(risk, action, decision)

# Get test data
db_rel_action_action <- rarr::db_rel_action_action
db_rel_dec_dec<- rarr::db_rel_dec_dec
db_rel_dec_action<- rarr::db_rel_dec_action
db_rel_risk_action <- rarr::db_rel_risk_action
db_rel_risk_dec <- rarr::db_rel_risk_dec
db_rel_risk_risk <- rarr::db_rel_risk_risk

# Wrangle data
rel_action_action <- rarr::wrangle_rel_action_action(db_rel_action_action)
rel_dec_dec <- rarr::wrangle_rel_dec_dec(db_rel_dec_dec)
rel_dec_action <- rarr::wrangle_rel_dec_action(db_rel_dec_action)
rel_risk_action <- rarr::wrangle_rel_risk_action(db_rel_risk_action)
rel_risk_dec <- rarr::wrangle_rel_risk_dec(db_rel_risk_dec)
rel_risk_risk <- rarr::wrangle_rel_risk_risk(db_rel_risk_risk)


relations<-rarr::create_relations(rel_action_action, rel_dec_action, rel_dec_dec,
                                  rel_risk_action,rel_risk_dec,rel_risk_risk)

relate_igraph<- igraph::graph_from_data_frame(d = relations,
                                              vertices = items,
                                              directed = FALSE)

related_blocks<-rarr::network_analysis(relate_igraph, items)

#example
block_table<-rarr::related_blocks_table(related_blocks)

# Test data type of block_table
tabletype<-class(block_table)
test_that("Check kable object", {
  expect_true("kableExtra" %in% tabletype)
  expect_true("knitr_kable" %in% tabletype)
})
