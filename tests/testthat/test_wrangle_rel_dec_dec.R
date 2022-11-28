# Get test data
db_rel_dec_dec <- rarr::db_rel_dec_dec

# Format rel_risk_action
rel_dec_dec <- wrangle_rel_dec_dec(db_rel_dec_dec)

test_that("check output data format", {
  expect_true(is.data.frame(rel_dec_dec))
  expect_true("related_decision" %in% colnames(rel_dec_dec))
  expect_true("related_decision_link" %in% colnames(rel_dec_dec))
  expect_true("decision_no" %in% colnames(rel_dec_dec))
  expect_true("id_type" %in% colnames(rel_dec_dec))
})

test_that("check errors", {
  expect_error(wrangle_rel_dec_dec("a"))
})
