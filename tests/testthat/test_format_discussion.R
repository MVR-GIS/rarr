# Get test data
db_discussion <- rarr::db_discussion

discussion <- format_discussion(db_discussion)

test_that("check output data format", {
  expect_true(is.data.frame(discussion))
  expect_true("fk_table_id" %in% colnames(discussion))
  expect_true("DISCUSSION" %in% colnames(discussion))
  expect_true("RESPONSIBLE_POC" %in% colnames(discussion))
  expect_true("poc_review_date" %in% colnames(discussion))
  expect_true("last_edited_date" %in% colnames(discussion))
})

test_that("test records removed", {
  expect_true(length(db_discussion$FK_TABLE_ID) >=
              length(discussion$FK_TABLE_ID))
})

test_that("check errors", {
  expect_error(format_discussion(1))
})
