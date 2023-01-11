# Get test data
db_risk <- rarr::db_risk

#Wrangle test data
risk <- rarr::wrangle_risk(db_risk)

#example
risk_pies(risk)

#test to see if ggplot type object is returned
p<-recordPlot(rarr::risk_pies(risk))
plot_type<-class(p)
test_that("Check if plot was produced", {
  expect_true("recordedplot" %in% plot_type)
})


