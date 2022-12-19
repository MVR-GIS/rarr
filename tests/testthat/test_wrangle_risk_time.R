# Get test data
db_risk <- rarr::db_risk

# Wrangle risk data
risk<- rarr::wrangle_risk(db_risk)

# Wrangle risk time data
risk_time<- rarr::wrangle_risk_time(risk)

test_that("check output data format", {
  expect_true(is.data.frame(risk_time))
  expect_true("id" %in% colnames(risk_time))
  expect_true("content" %in% colnames(risk_time))
  expect_true("title" %in% colnames(risk_time))
  expect_true("start" %in% colnames(risk_time))
  expect_true("end" %in% colnames(risk_time))
  expect_true("group" %in% colnames(risk_time))
  expect_true("risk_cat_code" %in% colnames(risk_time))
  expect_true("FEATURE" %in% colnames(risk_time))
  expect_true("TECHNICAL_POC" %in% colnames(risk_time))
  expect_true("eng_level" %in% colnames(risk_time))
})



test_that("check errors", {
  expect_error(wrangle_risk_time(1, active = TRUE))
  expect_error(wrangle_risk_time(db_risk, active = "1"))
})
