% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/format_decision.R
\name{format_decision}
\alias{format_decision}
\title{Format Decision}
\usage{
format_decision(db_decision)
}
\arguments{
\item{db_decision}{data frame; A standard decision data frame.}
}
\value{
A formatted data frame suitable for use by the report functions.
}
\description{
Formats an input decision data frame and prepares it for use
  by the the reporting functions in this package.
}
\examples{
# Get test data
db_decision <- rarr::db_decision

# Format decision
decision <- format_decision(db_decision)

}
