# Get test data
db_risk <- rarr::db_risk

# Wrangle risk data
risk<- rarr::wrangle_risk(db_risk)

#Wrangle risk_time_riskcategory
risk_time_riskcategory<-rarr::wrangle_risk_time_riskcat(risk)

test_that("check output data format", {
  expect_true(is.data.frame(risk_time_riskcategory))
  expect_true("id" %in% colnames(risk_time_riskcategory))
  expect_true("content" %in% colnames(risk_time_riskcategory))
  expect_true("title" %in% colnames(risk_time_riskcategory))
})

test_that("test records removed", {
  expect_true(length(db_risk$RISK_NO) >= length(risk$RISK_NO))
})

test_that("check inactive removed", {
  expect_true(length(filter(risk, ACTIVE == "No")$ACTIVE) == 0)
})

test_that("check errors", {
  expect_error(wrangle_risk_time_riskcat(1, active = TRUE))
  expect_error(wrangle_risk_time_riskcat(db_risk, active = "1"))
})

