# Get test data
risk_oracle <- readr::read_csv(system.file("extdata", "RISK_MAIN_VIEW.csv",
                                           package = "rarr"),
                               show_col_types = FALSE)

# remove test records
risk <- remove_test_records(risk_oracle, "RISK_NO")

test_that("check records removed", {
  expect_equal(length(risk_oracle$RISK_NO), 49)
  expect_equal(length(risk$RISK_NO), 47)
})

test_that("check errors", {
  expect_error(remove_test_records("1", "RISK_NO"))
  expect_error(remove_test_records(risk, "risk_number"))
})
