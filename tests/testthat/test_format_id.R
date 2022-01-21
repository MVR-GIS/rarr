# Get test data
risk_oracle <- readr::read_csv(system.file("extdata", "RISK_MAIN_VIEW.csv",
                                           package = "rarr"),
                               show_col_types = FALSE)

# Cleanup risk number for sorting
risk <- rarr::format_id(risk_oracle, "RISK_NO")

test_that("check id values", {
  expect_equal(dplyr::filter(risk, risk_no == "TR-011")$risk_no,
               "TR-011")
  expect_equal(dplyr::filter(risk, risk_no == "TR-006h")$risk_no,
               "TR-006h")
  expect_equal(dplyr::filter(risk, risk_no == "TR-018")$risk_no,
               "TR-018")
})

test_that("check errors", {
  expect_error(id_link("1", "RISK_NO"))
  expect_error(id_link(risk, "risk_number"))
})
