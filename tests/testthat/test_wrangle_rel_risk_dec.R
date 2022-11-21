# Get test data
db_rel_risk_dec <- rarr::db_rel_risk_dec

# Format rel_risk_action
rel_risk_dec <- wrangle_rel_risk_dec(db_rel_risk_dec)

test_that("check output data format", {
  expect_true(is.data.frame(rel_risk_dec))
  expect_true("risk_no" %in% colnames(rel_risk_dec))
  expect_true("risk_no_link" %in% colnames(rel_risk_dec))
  expect_true("decision_no" %in% colnames(rel_risk_dec))
  expect_true("decision_no_link" %in% colnames(rel_risk_dec))
  expect_true("id_type" %in% colnames(rel_risk_dec))
})

test_that("check errors", {
  expect_error(wrangle_rel_risk_dec("a"))
})
