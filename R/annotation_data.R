#' COG Funcational annotation data
#'For each COG, this dataset provides functional annotation. This includes identifying their functional category, the cluster's name, and the genes/pathways
#'they are associated with 
#' @docType data
#'
#' @usage data(og_annotation)
#'
#' @format A dataframe with 4877 rows and 7 variables 
#' \describe{
#'   \item{COG_ID}{the reference ID for a COG}
#'   \item{category}{the single letter encoding for the COG's functional category (can include multiple letters)}
#'   \item{name}{the biological name of the cluster}
#'   \item{gene_association}}{gene associated with the COG}
#'   \item{pathway_association}{funtional pathway associated with the COG}
#'   \item{cog_pubmed}{Reference ID for the COG associated with the PubMed database}
#'   \item{cog_pdb}{Reference ID for the COG associated with the PDB database}
#' }
#' @keywords datasets
#'
#'
#' @source \url{https://www.ncbi.nlm.nih.gov/research/cog-project/}
#'
"og_categories"