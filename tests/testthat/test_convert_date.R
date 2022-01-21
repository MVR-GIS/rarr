# Get test data
risk_oracle <- readr::read_csv(system.file("extdata", "RISK_MAIN_VIEW.csv",
                                           package = "rarr"),
                               show_col_types = FALSE)

# Convert date character fields
risk <- convert_date(risk_oracle)

test_that("check if dates are POSIXct", {
  expect_true(lubridate::is.POSIXct(risk$POC_REVIEW_DATE))
  expect_true(lubridate::is.POSIXct(risk$START_DATE))
  expect_true(lubridate::is.POSIXct(risk$END_DATE))
  expect_true(lubridate::is.POSIXct(risk$LEVEL_DATE))
  expect_true(lubridate::is.POSIXct(risk$LAST_EDITED_DATE))
})

test_that("check errors", {
  expect_error(convert_date("1"))
})
