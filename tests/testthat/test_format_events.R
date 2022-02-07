# Get test data
events_table <- rarr::events_table

events <- format_events(events_table)

test_that("check output data format", {
  expect_true(is.data.frame(events))
  expect_true("fk_table_id" %in% colnames(events))
  expect_true("fk_table_id_link" %in% colnames(events))
  expect_true("eng_level" %in% colnames(events))
  expect_true("level_date" %in% colnames(events))
  expect_true("last_edited_date" %in% colnames(events))
  expect_true("level_end_date" %in% colnames(events))
  expect_true("id_type" %in% colnames(events))
})

test_that("test records removed", {
  expect_true(length(events_table$FK_TABLE_ID) >= length(events$FK_TABLE_ID))
})

test_that("check errors", {
  expect_error(format_risk(1))
})
