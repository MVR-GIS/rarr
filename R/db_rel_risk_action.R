#' Risks Related to Actions
#'
#' A table of risk items and the action items they are related to. These are
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
#'   \item{ACTION_OBID}{Geodatabase action item unique identifier, numeric}
#'   \item{ACTION_NO}{Action item number unique identifier, character}
#'   \item{ACTION}{Description of the action item, character}
#'   \item{ACTION_ACTIVE}{Is the item currently active (Yes/No)? character}
#'   \item{REL_OBID}{not used}
#'   \item{REL_RISK_OBID}{not used}
#' }
#'
#' @keywords datasets
#'
#' @source \url{https://egis-app.mvr.usace.army.mil/ords/f?p=131}
#'
"db_rel_risk_action"
