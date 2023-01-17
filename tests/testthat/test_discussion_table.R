#Get test data
db_discussion <- rarr::db_discussion

discussion <- rarr::wrangle_discussion(db_discussion)

x<-"ACT-006"


discussion_item <- discussion %>%
  dplyr::filter(TABLE_NAME == "ACTION_REGISTER") %>%
  dplyr::filter(fk_table_id == x)

#example
discussion_table<-rarr::discussion_table(discussion_item, discussion_item$fk_table_id)

#test to see if kable type object is returned
plot_type<-class(discussion_table)
test_that("Check discussion table object", {
  expect_true("kableExtra" %in% plot_type)
  expect_true("knitr_kable" %in% plot_type)
})
