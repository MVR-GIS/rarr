#' Action Items
#'
#' A table of action items and their key attributes for project risk analysis.
#'
#' @docType data
#'
#' @format A data frame of action items with the following attributes:
#' \describe{
#'   \item{OBJECTID}{Geodatabase unique identifier, numeric}
#'   \item{ACTION_NO}{Action item number unique identifier, character}
#'   \item{ACTION}{Description of the action item, character}
#'   \item{START_DATE}{Start date of the action, POSIXct}
#'   \item{END_DATE}{End date of the action, POSIXct}
#'   \item{TECHNICAL_POC}{Technical POC for the action, character}
#'   \item{POC_REVIEW_DATE}{The last date the technical POC reviewed the action
#'                          item, POSIXct}
#'   \item{FEATURE}{The primary project feature impacted by this action,
#'                  character}
#'   \item{ACTIVE}{Is the item currently active (Yes/No)? character}
#'   \item{DISCIPLINE}{The primary discipline of the item (domain: discipline),
#'                     character}
#'   \item{MANAGEMENT_STATUS}{The current management status of the item
#'                            (domain: management_status, Open/Closed),
#'                            character}
#'   \item{OWNER}{The owner of the item, character}
#'   \item{ENG_LEVEL}{Current engagement level of the item (domain: Engagement,
#'                    Level, 1-5), character}
#'   \item{LEVEL_DATE}{The date of the current enegement level, POSIXct}
#'   \item{LAST_EDITED_DATE}{The date the item was last eddited, POSIXct}
#'   \item{FK_TABLE_ID}{not used}
#' }
#'
#' @keywords datasets
#'
#' @source \url{https://egis-app.mvr.usace.army.mil/ords/f?p=131}
#'
"action_table"
