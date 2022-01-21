#' @title Format ID
#'
#' @description Formats ID field into a standard format to support reporting.
#'
#' @export
#'
#' @param df          data frame; Data frame containing the id_field to be
#'                    formatted.
#' @param id_field    character; The column name of the id field to be
#'                    formatted.
#'
#' @details The input `id_field` is assumed to contain three parts: an
#' alphabetic code, a dash separator, a sequential numeric second part, and an
#' alphabetic third part.
#'
#' @return The input data frame with a new field formatted according the
#' function's format rules.
#'
#' @examples
#' # Get test data
#' risk_oracle <- readr::read_csv(system.file("extdata", "RISK_MAIN_VIEW.csv",
#'                                            package = "rarr"),
#'                                show_col_types = FALSE)
#'
#' # Cleanup risk number for sorting
#' risk <- rarr::format_id(risk_oracle, "RISK_NO")
#'
#' @importFrom stringr str_to_lower str_extract str_pad str_c
#' @importFrom tidyr replace_na
#' @importFrom rlang enquo sym quo_name
#' @importFrom dplyr mutate relocate rename select
#'
format_id <- function(df, id_field) {
  # Check inputs
  if(!is.data.frame(df)) {stop("df must be a data frame")}
  if(!(id_field %in% colnames(df))) {stop("id_field is not a field in df")}

  # Convert the id_field to lower case
  id_field_lower <- str_to_lower(id_field)

  # enquote the id_fields
  in_col <- enquo(id_field)
  id     <- enquo(id_field_lower)

  df <- df %>%
    mutate(cat_code = str_extract(!!sym(quo_name(in_col)),
                                  "\\w+\\b"),
           number_string = str_extract(!!sym(quo_name(in_col)),
                                       "\\b\\w+$"),
           number = str_extract(number_string, "\\d+"),
           letter_na = str_extract(number_string, "\\D+"),
           letter = replace_na(letter_na, replace = ""),
           letter_lower = str_to_lower(letter),
           padded = str_pad(number, width = 3, side = "left", pad = "0"),
           id_fixed = str_c(cat_code, "-", padded, letter_lower)
           ) %>%
    rename(!!id := id_fixed) %>%
    select(!c(cat_code, number_string, number, letter_na, letter,
              letter_lower, padded)) %>%
    relocate(!!id, .after = !!in_col)

  return(df)
}
