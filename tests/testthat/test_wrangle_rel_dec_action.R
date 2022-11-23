# Get test data
db_rel_dec_action <- rarr::db_rel_dec_action

# Format rel_dec_action
rel_dec_action <- wrangle_rel_dec_action(db_rel_dec_action)

test_that("check output data format", {
  expect_true(is.data.frame(rel_dec_action))
  expect_true("decision_no" %in% colnames(rel_dec_action))
  expect_true("decision_no_link" %in% colnames(rel_dec_action))
  expect_true("action_no" %in% colnames(rel_dec_action))
  expect_true("action_no_link" %in% colnames(rel_dec_action))
  expect_true("id_type" %in% colnames(rel_dec_action))
})

test_that("check errors", {
  expect_error(wrangle_rel_dec_action("a"))
})
