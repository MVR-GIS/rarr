# Get test data
action <- rarr::db_action
action <-rarr::wrangle_action(action)
decision <- rarr::db_decision
decision <- rarr:: wrangle_decision(decision)
risk <- rarr::db_risk
risk <-rarr::wrangle_risk(risk)

#Wrangle test data into item data frame
items <- rarr::wrangle_items(risk,action,decision)

test_that("check output data format", {
  expect_true(is.data.frame(items))
  expect_true("item_id" %in% colnames(items))
  expect_true("item_link" %in% colnames(items))
  expect_true("description" %in% colnames(items))
  expect_true("id_type" %in% colnames(items))
  expect_true("FEATURE" %in% colnames(items))
  expect_true("DISCIPLINE" %in% colnames(items))
})


test_that("check errors", {
  expect_error(wrangle_items(1))
})
