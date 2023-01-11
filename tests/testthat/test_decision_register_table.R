#Get test data
db_decision <- rarr::db_decision

decision <- wrangle_decision(db_decision)

#example
decision_register<-decision_register_table(decision)

#test to see if kable type object is returned
plot_type<-class(decision_register)
test_that("Check discussion table object", {
  expect_true("kableExtra" %in% plot_type)
  expect_true("knitr_kable" %in% plot_type)
})
