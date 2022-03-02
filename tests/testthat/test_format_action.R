# Get test data
db_action <- rarr::db_action

# Format risk
action <- format_action(db_action)


test_that("check output data format", {
  expect_true(is.data.frame(action))
  expect_true("action_no" %in% colnames(action))
  expect_true("action_no_link" %in% colnames(action))
  expect_true("start_date" %in% colnames(action))
  expect_true("end_date" %in% colnames(action))
  expect_true("poc_review_date" %in% colnames(action))
  expect_true("eng_level" %in% colnames(action))
  expect_true("level_date" %in% colnames(action))
  expect_true("last_edited_date" %in% colnames(action))
  expect_true("id_type" %in% colnames(action))
})

test_that("check errors", {
  expect_error(format_action("a"))
})
