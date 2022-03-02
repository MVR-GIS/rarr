#' Risks Related to Risks
#'
#' A table of risk items and the risk items they are related to. These are
#' two-way (undirected) relationships.
#'
#' @docType data
#'
#' @format A data frame of related items with the following attributes:
#' \describe{
#'   \item{RISK_NO}{Risk item number unique identifier, character}
#'   \item{RISK_ACTIVE}{Is the item currently active (Yes/No)? character}
#'   \item{RELATED_RISK}{Related risk item number unique identifier, character}
#'   \item{RELATED_RISK_CONCERN}{Description of the risk item, character}
#'   \item{REL_RISK_ACTIVE}{Is the item currently active (Yes/No)? character}
#' }
#'
#' @keywords datasets
#'
#' @source \url{https://egis-app.mvr.usace.army.mil/ords/f?p=131}
#'
"rel_risk_risk_table"
