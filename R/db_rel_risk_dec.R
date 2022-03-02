#' Risks Related to Decisions
#'
#' A table of risk items and the decision items they are related to. These are
#' two-way (undirected) relationships.
#'
#' @docType data
#'
#' @format A data frame of related items with the following attributes:
#' \describe{
#'   \item{RISK_OBID}{Geodatabase risk item unique identifier, numeric}
#'   \item{RISK_NO}{Risk item number unique identifier, character}
#'   \item{CONCERNS}{Description of the risk item, character}
#'   \item{RISK_ACTIVE}{Is the item currently active (Yes/No)? character}
#'   \item{DECISION_OBID}{Geodatabase decision item unique identifier, numeric}
#'   \item{DECISION_NO}{Decision item number unique identifier, character}
#'   \item{DECISION}{Description of the decision item, character}
#'   \item{DECISION_ACTIVE}{Is the item currently active (Yes/No)? character}
#' }
#'
#' @keywords datasets
#'
#' @source \url{https://egis-app.mvr.usace.army.mil/ords/f?p=131}
#'
"db_rel_risk_dec"
