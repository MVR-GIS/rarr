#Get test data
db_action <- rarr::db_action

action <- wrangle_action(db_action)

#example
action_register<- action_register_table(action)

#test to see if kable type object is returned
plot_type<-class(action_register)
test_that("Check discussion table object", {
  expect_true("kableExtra" %in% plot_type)
  expect_true("knitr_kable" %in% plot_type)
})
