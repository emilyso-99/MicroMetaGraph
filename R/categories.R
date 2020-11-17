#' COG Information data
#'In the functional annotation dataset (og_categories), a COG's functional category is represented by a single letter coding. This dataset 
#'translates the single letter encoding into a more detailed description
#' @docType data
#'
#' @usage data(categories)
#'
#' @format A dataframe with 1048575 rows and 3 variables 
#' \describe{
#'   \item{group1}{reference ID for the first COG of the pair}
#'   \item{group2}{reference ID for the second COG of the pair}
#'   \item{associationscore}{association score between the two COGs}
#' }
#' @keywords datasets
#'
#'
#' @source \url{https://stringdb-static.org/cgi/download.pl?sessionId=A8sx4Z24Onr2}
#'
"categories"