#Get test data
db_risk <- rarr::db_risk

risk <- wrangle_risk(db_risk)


#example
risk_register<-rarr::risk_register_table(risk)

#test to see if kable type object is returned
plot_type<-class(risk_register)
test_that("Check risk table object", {
  expect_true("kableExtra" %in% plot_type)
  expect_true("knitr_kable" %in% plot_type)
})
