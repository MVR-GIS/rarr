# Get test data
db_rel_risk_risk <- rarr::db_rel_risk_risk

# Format rel_risk_risk
rel_risk_risk <- wrangle_rel_risk_risk(db_rel_risk_risk)

test_that("check output data format", {
  expect_true(is.data.frame(rel_risk_risk))
  expect_true("risk_no" %in% colnames(rel_risk_risk))
  expect_true("related_risk" %in% colnames(rel_risk_risk))
  expect_true("related_risk_link" %in% colnames(rel_risk_risk))
  expect_true("id_type" %in% colnames(rel_risk_risk))
})

test_that("check errors", {
  expect_error(wrangle_rel_risk_risk("a"))
})
