% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pandoc_header.R
\name{pandoc_header}
\alias{pandoc_header}
\title{Create Pandoc ATX Header}
\usage{
pandoc_header(text, level = 1, identifier = NA, number = TRUE, list = TRUE)
}
\arguments{
\item{text}{character; Text of the header.}

\item{level}{integer; Level of the header.}

\item{identifier}{character; Text used for specifying an explicit anchor
link.}

\item{number}{logical; Should the header be numbered or unnumbered?
Default to TRUE (numbered).}

\item{list}{logical; Should heading be included in the table
of contents? Default to TRUE (listed).}
}
\value{
None (invisible NULL). Returns the Pandoc ATX-style header using
 the `cat` function.
}
\description{
Allows programmatic creation of a Pandoc ATX-style header
  with attributes. The currently supported set of Pandoc header attributes
  is: explicit identifier, numbered-unnumbered, listed-unlisted.
}
\details{
[`pandoc` extension-header_attributes](https://pandoc.org/MANUAL.html#extension-header_attributes)
}
\examples{
pandoc_header("TR-001", 2)

}
