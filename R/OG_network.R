#' The OG Network Function 
#' 
#' from beginning to end, using the query functions that were done before, this function constructs a protein interaction network 
#' that is orthog specific. Each node is a COG group, with information on the functional annotation  and the input proteins present in each ortholog group. there 
#' are lines connecting interaction scores 
#' @param classifiers A list that contains a sequence of NCBI/Genbank protein ids
#' @return graph of interaction network 
#' @keywords interaction network 
#' @export
#' @examples
#' \dontrun {
#' protein_network([Protein X])
#' }
#'

ortholog_network <- function(genes){
}