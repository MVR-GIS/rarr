#' @title Remove Test Records
#'
#' @description Removes test records from the input data frame.
#'
#' @export
#'
#' @param df        data frame; The data frame containing test records to
#'                  be removed.
#' @param id_field  character; id field to be checked for removal
#'
#' @return A data frame with the test records removed.
#'
#' @examples
#' # Get test data
#' risk_oracle <- readr::read_csv(system.file("extdata", "RISK_MAIN_VIEW.csv",
#'                                            package = "rarr"),
#'                                show_col_types = FALSE)
#'
#' # remove test records
#' risk <- remove_test_records(risk_oracle, "RISK_NO")
#'
#' @importFrom dplyr mutate filter select
#' @importFrom magrittr %>%
#'
remove_test_records <- function(df, id_field) {
  # Check inputs
  if(!is.data.frame(df)) {stop("df must be a data frame")}
  if(!(id_field %in% colnames(df))) {stop("id_field is not a field in df")}

  df <- df %>%
    mutate(id := str_to_lower(!!sym(id_field))) %>%
    mutate(id_test = str_extract(id, "test")) %>%
    filter(!id_test %in% "test") %>%
    select(!c(id, id_test))

  return(df)
}
