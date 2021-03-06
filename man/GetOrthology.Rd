% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/GetOrthology.R
\name{GetOrthology}
\alias{GetOrthology}
\title{The Get Orthology Function}
\usage{
GetOrthology(classifiers)
}
\arguments{
\item{classifiers}{A list that contains a sequence of protein/genes classifiers}
}
\value{
dataframe containing the orthologous groups present in the input
sequence, and their respective ortholog groups
}
\description{
This function retrieves the corresponding ortholog groups for the input set of proteins, by retrieving
their ortholog groups and that orthologs members (derived from EGGNOG Database)
}
\examples{
{
GetOrthology(c("644223.PAS_chr1-1_0187","5270.UM01492.1","51453.JGI55417"))
}
"Protein with ID 644223.PAS_chr1-1_0187 belongs to the group COG5271"
"Protein with ID 5270.UM01492.1 belongs to the group COG0515"
"Protein with ID 51453.JGI55417 belongs to the group COG5245"
}
\keyword{orthology}
