#Get test data
db_risk <- rarr::db_risk

db_action <- rarr::db_action

db_decision <- rarr::db_decision

#Wrangle test data
risk <- rarr::wrangle_risk(db_risk)
action <- rarr::wrangle_action(db_action)
decision <- rarr::wrangle_decision(db_decision)

items<-rarr::create_items(risk, action, decision)

#Test to see if create-items df contains correct data
test_that("check output data format", {
  expect_true(is.data.frame(items))
  expect_true("item_id" %in% colnames(items))
  expect_true("item_link" %in% colnames(items))
  expect_true("description" %in% colnames(items))
  expect_true("id_type" %in% colnames(items))
  expect_true("FEATURE" %in% colnames(items))
  expect_true("DISCIPLINE" %in% colnames(items))
})
