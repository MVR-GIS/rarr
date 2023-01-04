# Get test data
db_risk <- rarr::db_risk

# Wrangle risk data
risk <- rarr::wrangle_risk(db_risk)

#Wrangle risk time dataframe
risk_time <- rarr::wrangle_risk_time(risk)

#Wrangle risk time categories
risk_time_riskcategory<-rarr::wrangle_risk_time_riskcat(risk)

#example
t <- timeline(risk_df=risk_time, groups_df= risk_time_riskcategory,
         height = "700px",
         start = "2021-01-01",
         end = "2025-01-01")

#test to see if timevis type object is returned
plot_type<-class(t)
test_that("Check timevis object", {
  expect_true("timevis" %in% plot_type)
  expect_true("htmlwidget" %in% plot_type)
})
