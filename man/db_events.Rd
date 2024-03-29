% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/db_events.R
\docType{data}
\name{db_events}
\alias{db_events}
\title{Event Items}
\format{
A data frame of event items with the following attributes:
\describe{
  \item{OBJECTID}{Geodatabase unique identifier, numeric}
  \item{TABLE_NAME}{The table name that the discussion item belogs to,
                    (one of: ACTION_REGISTER, DECISION_REGISTER,
                    RISK_REGISTER, character}
  \item{FK_TABLE_ID}{The value of the unique identifier the table specified
                     in TABLE_NAME, character}
  \item{DESCRIPTION}{Description of the item, character}
  \item{ENG_LEVEL}{Current engagement level of the item (domain: Engagement,
                   Level 1-5), character}
  \item{LEVEL_DATE}{The date of the current engagement level, POSIXct}
  \item{LAST_EDITED_DATE}{The date the item was last eddited, POSIXct}
  \item{CREATED_USER}{not used}
  \item{CREATED_DATE}{not used}
  \item{LAST_EDITED_USER}{not used}
}
}
\source{
\url{https://egis-app.mvr.usace.army.mil/ords/f?p=131}
}
\usage{
db_events
}
\description{
A table of event items and their key attributes for project risk analysis.
}
\keyword{datasets}
