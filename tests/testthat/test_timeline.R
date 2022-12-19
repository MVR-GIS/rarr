# Get test data
db_risk <- rarr::db_risk

# Wrangle risk data
risk <- rarr::wrangle_risk(db_risk)

#Wrangle risk time dataframe
risk_time <- rarr::wrangle_risk_time(risk)

#Wrangle risk time categories
risk_time_riskcategory<-rarr::wrangle_risk_time_riskcat(risk)


timeline(risk_df=risk_time, groups_df= risk_time_riskcategory, height = "700px",
         start = "2021-01-01",
         end = "2025-01-01")
