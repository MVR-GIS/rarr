# Get test data
db_decision <- rarr::db_decision

# Format decision
decision <- format_decision(db_decision)

test_that("check output data format", {
  expect_true(is.data.frame(decision))
  expect_true("decision_no" %in% colnames(decision))
  expect_true("decision_no_link" %in% colnames(decision))
  expect_true("decision_date" %in% colnames(decision))
  expect_true("poc_review_date" %in% colnames(decision))
  expect_true("eng_level" %in% colnames(decision))
  expect_true("level_date" %in% colnames(decision))
  expect_true("last_edited_date" %in% colnames(decision))
  expect_true("id_type" %in% colnames(decision))
})

test_that("check errors", {
  expect_error(format_decision("a"))
})

