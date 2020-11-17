#' COG Information data
#'
#' Given the various reference IDs for a certain protein, this dataset maps the protein to the correct Cluster of Orthologous Group (COG),
#' a classification that represents function categorization
#'
#' @docType data
#'
#' @usage data(orthologs_info)
#'
#' @format A dataframe with 3455853 rows and 11 variables 
#' \describe{
#'   \item{GenBankID}{reference ID for protein in GenBank database}
#'   \item{NCBI_ID}{reference ID of protein in NCBI database}
#'   \item{ProteinID}{association score between the two COGs}
#'   \item{Proteinlenght}{length of protein}
#'   \item{COGID}{reference ID of the COG the protein belongs to}
#' }
#' @keywords datasets
#'
#'
#' @source \url{https://www.ncbi.nlm.nih.gov/research/cog-project/}
#'
"orthologs_info"