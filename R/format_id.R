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
#' db_risk <- rarr::db_risk
#'
#' # Cleanup risk number for sorting
#' risk <- rarr::format_id(db_risk, "RISK_NO")
#'
#' @importFrom stringr str_to_lower str_extract str_pad str_c
#' @importFrom tidyr replace_na
#' @importFrom rlang enquo sym quo_name .data :=
#' @importFrom dplyr mutate relocate rename select
#' @importFrom magrittr %>%
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
           number = str_extract(.data$number_string, "\\d+"),
           letter_na = str_extract(.data$number_string, "\\D+"),
           letter = replace_na(.data$letter_na, replace = ""),
           letter_lower = str_to_lower(.data$letter),
           padded = str_pad(.data$number, width = 3, side = "left", pad = "0"),
           id_fixed = str_c(.data$cat_code, "-",
                            .data$padded,
                            .data$letter_lower)) %>%
    rename(!!id := .data$id_fixed) %>%
    select(!c(.data$cat_code, .data$number_string, .data$number,
              .data$letter_na, .data$letter, .data$letter_lower,
              .data$padded)) %>%
    relocate(!!id, .after = !!in_col)

  return(df)
}
