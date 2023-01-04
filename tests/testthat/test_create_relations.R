
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

test_that("check output data format", {
  expect_true(is.data.frame(relations))
  expect_true("from" %in% colnames(relations))
  expect_true("to" %in% colnames(relations))
  expect_true("id_type_1" %in% colnames(relations))
  expect_true("id_type_2" %in% colnames(relations))
})
