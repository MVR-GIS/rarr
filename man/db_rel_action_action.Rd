% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/db_rel_action_action.R
\docType{data}
\name{db_rel_action_action}
\alias{db_rel_action_action}
\title{Actions Related to other Actions}
\format{
A data frame of related items with the following attributes:
\describe{
  \item{ACTION_NO}{Action item number unique identifier, character}
  \item{ACTION_ACTIVE}{Is the item currently active (Yes/No)? character}
  \item{RELATED_ACTION}{Related action item number unique identifier,
                        character}
  \item{ACTION}{Description of the action item, character}
  \item{REL_ACTION_ACTIVE}{Is the related item currently active (Yes/No)?
                           character}
}
}
\source{
\url{https://egis-app.mvr.usace.army.mil/ords/f?p=131}
}
\usage{
db_rel_action_action
}
\description{
A table of action items and the action items they are related to. These are
two-way (undirected) relationships.
}
\keyword{datasets}
