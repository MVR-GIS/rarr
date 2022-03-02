#' Decisions Related to other Decisions
#'
#' A table of decision items and the decision items they are related to. These are
#' two-way (undirected) relationships.
#'
#' @docType data
#'
#' @format A data frame of related items with the following attributes:
#' \describe{
#'   \item{DECISION_NO}{Decision item number unique identifier, character}
#'   \item{DECISION_ACTIVE}{Is the item currently active (Yes/No)? character}
#'   \item{RELATED_DECISION}{Related decision item number unique identifier,
#'                           character}
#'   \item{DECISION}{Description of the action item, character}
#'   \item{REL_DEC_ACTIVE}{Is the related item currently active (Yes/No)?
#'                        character}
#' }
#'
#' @keywords datasets
#'
#' @source \url{https://egis-app.mvr.usace.army.mil/ords/f?p=131}
#'
"rel_dec_dec_table"
