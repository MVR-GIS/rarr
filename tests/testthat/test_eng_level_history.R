# Get test data
db_events <- rarr::db_events
library(magrittr)

events <- wrangle_events(db_events)
x <- "CA-003"

events <- events %>%
  dplyr::filter(TABLE_NAME == "RISK_REGISTER") %>%
  dplyr::filter(fk_table_id == x)

#Example
eng_level_table <- eng_level_history(events, events$fk_table_id,
show_item_link = TRUE)

#test that output is kable
plot_type<-class(eng_level_table)
test_that("Check eng_level_table object", {
  expect_true("kableExtra" %in% plot_type)
  expect_true("knitr_kable" %in% plot_type)
})
