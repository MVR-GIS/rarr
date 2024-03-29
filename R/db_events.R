#' Event Items
#'
#' A table of event items and their key attributes for project risk analysis.
#'
#' @docType data
#'
#' @format A data frame of event items with the following attributes:
#' \describe{
#'   \item{OBJECTID}{Geodatabase unique identifier, numeric}
#'   \item{TABLE_NAME}{The table name that the discussion item belogs to,
#'                     (one of: ACTION_REGISTER, DECISION_REGISTER,
#'                     RISK_REGISTER, character}
#'   \item{FK_TABLE_ID}{The value of the unique identifier the table specified
#'                      in TABLE_NAME, character}
#'   \item{DESCRIPTION}{Description of the item, character}
#'   \item{ENG_LEVEL}{Current engagement level of the item (domain: Engagement,
#'                    Level 1-5), character}
#'   \item{LEVEL_DATE}{The date of the current engagement level, POSIXct}
#'   \item{LAST_EDITED_DATE}{The date the item was last eddited, POSIXct}
#'   \item{CREATED_USER}{not used}
#'   \item{CREATED_DATE}{not used}
#'   \item{LAST_EDITED_USER}{not used}
#' }
#'
#' @keywords datasets
#'
#' @source \url{https://egis-app.mvr.usace.army.mil/ords/f?p=131}
#'
"db_events"
