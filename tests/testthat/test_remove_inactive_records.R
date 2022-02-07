# Get test data
risk_table <- rarr::risk_table

risk_active <- remove_inactive_records(risk_table, active = TRUE)
risk_inactive <- remove_inactive_records(risk_table, active = FALSE)

# Data frame with no ACTIVE field
events_table <- rarr::events_table
events_active <- remove_inactive_records(events_table)

test_that("check active values", {
  expect_true(length(filter(risk_active, ACTIVE == "No")$ACTIVE) == 0)
  expect_true(length(filter(risk_inactive, ACTIVE == "Yes")$ACTIVE) == 0)
})

test_that("handle table with no ACTIVE field", {
  expect_true(length(events_table$OBJECTID) == length(events_active$OBJECTID))
})

test_that("check errors", {
  expect_error(remove_inactive_records(1, active = TRUE))
  expect_error(remove_inactive_records(risk_table, active = "1"))
})
