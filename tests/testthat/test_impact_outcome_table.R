# Get test data
db_risk <- rarr::db_risk

# Wrangle risk data
risk <- rarr::wrangle_risk(db_risk)

#example
impact_outcome_table<-create_impact_outcome_table(risk)

#test to see if kable type object is returned
plot_type<-class(impact_outcome_table)
test_that("Check impact outcome table object", {
  expect_true("kableExtra" %in% plot_type)
  expect_true("knitr_kable" %in% plot_type)
})
