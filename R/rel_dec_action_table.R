#' Decisions Related to other Actions
#'
#' A table of decision items and the action items they are related to. These are
#' two-way (undirected) relationships.
#'
#' @docType data
#'
#' @format A data frame of related items with the following attributes:
#' \describe{
#'   \item{DECISION_OBID}{Geodatabase decision item unique identifier, numeric}
#'   \item{DECISION_NO}{Decision item number unique identifier, character}
#'   \item{DECISION}{Description of the decision item, character}
#'   \item{DECISION_ACTIVE}{Is the item currently active (Yes/No)? character}
#'   \item{ACTION_OBID}{Geodatabase action item unique identifier, numeric}
#'   \item{ACTION_NO}{Action item number unique identifier, character}
#'   \item{ACTION}{Description of the action item, character}
#'   \item{ACTION_ACTIVE}{Is the related item currently active (Yes/No)?
#'                        character}
#' }
#'
#' @keywords datasets
#'
#' @source \url{https://egis-app.mvr.usace.army.mil/ords/f?p=131}
#'
"rel_dec_action_table"
