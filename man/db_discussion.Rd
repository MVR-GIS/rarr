% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/db_discussion.R
\docType{data}
\name{db_discussion}
\alias{db_discussion}
\title{Discussion Items}
\format{
A data frame of discussion items with the following attributes:
\describe{
  \item{OBJECTID}{Geodatabase unique identifier, numeric}
  \item{TABLE_NAME}{The table name that the discussion item belogs to,
                    (one of: ACTION_REGISTER, DECISION_REGISTER,
                    RISK_REGISTER, character}
  \item{FK_TABLE_ID}{The value of the unique identifier the table specified
                     in TABLE_NAME, character}
  \item{DISCUSSION}{Description of the discussion item, character}
  \item{ACTIVE}{Is the item currently active (Yes/No)? character}
  \item{RESPONSIBLE_POC}{Technical POC for the discussion item, character}
  \item{POC_REVIEW_DATE}{The last date the technical POC reviewed the
                         discussion item, POSIXct}
  \item{LAST_EDITED_DATE}{The date the item was last eddited, POSIXct}
  \item{LOGGED_BY}{not used}
  \item{LOG_DATE}{not used}
  \item{CREATED_USER}{not used}
  \item{CREATED_DATE}{not used}
  \item{LAST_EDITED_USER}{not used}
}
}
\source{
\url{https://egis-app.mvr.usace.army.mil/ords/f?p=131}
}
\usage{
db_discussion
}
\description{
A table of discussion items and their key attributes for project risk analysis.
}
\keyword{datasets}
