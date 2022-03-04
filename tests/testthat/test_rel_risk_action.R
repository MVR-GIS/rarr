# Get test data
db_rel_risk_action <- rarr::db_rel_risk_action

# Format rel_risk_action
rel_risk_action <- format_rel_risk_action(db_rel_risk_action)

test_that("check output data format", {
  expect_true(is.data.frame(rel_risk_action))
  expect_true("risk_no" %in% colnames(rel_risk_action))
  expect_true("risk_no_link" %in% colnames(rel_risk_action))
  expect_true("action_no" %in% colnames(rel_risk_action))
  expect_true("action_no_link" %in% colnames(rel_risk_action))
  expect_true("id_type" %in% colnames(rel_risk_action))
})

test_that("check errors", {
  expect_error(format_rel_risk_action("a"))
})
