# Get test data
db_rel_action_action <- rarr::db_rel_action_action

# Format rel_action_action
rel_action_action <- format_rel_action_action(db_rel_action_action)

test_that("check output data format", {
  expect_true(is.data.frame(rel_action_action))
  expect_true("action_no" %in% colnames(rel_action_action))
  expect_true("related_action" %in% colnames(rel_action_action))
  expect_true("related_action_link" %in% colnames(rel_action_action))
  expect_true("id_type" %in% colnames(rel_action_action))
})

test_that("check errors", {
  expect_error(format_rel_action_action("a"))
})

