# Get test data
db_risk <- rarr::db_risk

# Cleanup risk number for sorting
risk <- format_id(db_risk, "RISK_NO")

# Create hyperlink to risk_no
risk <- id_link(risk, "risk_no")


test_that("check link structure", {
  expect_equal(dplyr::filter(risk, risk_no == "TR-011")$risk_no_link,
               "[TR-011](#risk-item-tr-011)")
  expect_equal(dplyr::filter(risk, risk_no == "TR-006h")$risk_no_link,
               "[TR-006h](#risk-item-tr-006h)")
  expect_equal(dplyr::filter(risk, risk_no == "TR-018")$risk_no_link,
               "[TR-018](#risk-item-tr-018)")
})

test_that("check errors", {
  expect_error(id_link("1", "RISK_NO"))
  expect_error(id_link(risk, "risk_number"))
})
