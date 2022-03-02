# Get test data
db_risk <- rarr::db_risk

# remove test records
risk <- remove_test_records(db_risk, "RISK_NO")

test_that("check test records removed", {
  expect_equal(length(db_risk$RISK_NO), 52)
  expect_equal(length(risk$RISK_NO), 51)
})

test_that("check errors", {
  expect_error(remove_test_records("1", "RISK_NO"))
  expect_error(remove_test_records(risk, "risk_number"))
})
