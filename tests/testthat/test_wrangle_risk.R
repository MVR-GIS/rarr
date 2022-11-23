# Get test data
db_risk <- rarr::db_risk

# Format risk
risk <- wrangle_risk(db_risk)
risk_inactive <- wrangle_risk(db_risk, active = FALSE)

test_that("check output data format", {
  expect_true(is.data.frame(risk))
  expect_true("risk_no" %in% colnames(risk))
  expect_true("risk_no_link" %in% colnames(risk))
  expect_true("start_date" %in% colnames(risk))
  expect_true("end_date" %in% colnames(risk))
  expect_true("risk_cat_code" %in% colnames(risk))
  expect_true("cost_risk_color" %in% colnames(risk))
  expect_true("schedule_risk_color" %in% colnames(risk))
  expect_true("efficacy_risk_color" %in% colnames(risk))
  expect_true("eng_level" %in% colnames(risk))
  expect_true("level_date" %in% colnames(risk))
  expect_true("id_type" %in% colnames(risk))
})

test_that("test records removed", {
  expect_true(length(db_risk$RISK_NO) >= length(risk$RISK_NO))
})

test_that("check inactive removed", {
  expect_true(length(filter(risk, ACTIVE == "No")$ACTIVE) == 0)
})

test_that("check errors", {
  expect_error(wrangle_risk(1, active = TRUE))
  expect_error(wrangle_risk(db_risk, active = "1"))
})
