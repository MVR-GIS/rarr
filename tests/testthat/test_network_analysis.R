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



related_blocks<-rarr::network_analysis(relations, items)

test_that("check output data format", {
  expect_true(is.data.frame(related_blocks))
  expect_true("block_no" %in% colnames(related_blocks))
  expect_true("item_id" %in% colnames(related_blocks))
  expect_true("degree" %in% colnames(related_blocks))
  expect_true("adj_count" %in% colnames(related_blocks))
  expect_true("item_link" %in% colnames(related_blocks))
  expect_true("description" %in% colnames(related_blocks))
  expect_true("id_type" %in% colnames(related_blocks))
  expect_true("FEATURE" %in% colnames(related_blocks))
  expect_true("DISCIPLINE" %in% colnames(related_blocks))
})
