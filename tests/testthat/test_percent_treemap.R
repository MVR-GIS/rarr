# Get test data
db_risk <- rarr::db_risk

# Wrangle risk data
risk <- rarr::wrangle_risk(db_risk)

#example

p1 <- rarr::percent_treemap(risk, RISKCATEGORY,"Risk Categories")


#test to see if ggplot type object is returned
plot_type<-class(p1)
test_that("Check ggplot object", {
  expect_true("gg" %in% plot_type)
  expect_true("ggplot" %in% plot_type)
})
