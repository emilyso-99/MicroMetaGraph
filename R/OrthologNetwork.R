#' The OG Network Function 
#' 
#' from beginning to end, using the query functions that were done before, this function constructs a protein interaction network 
#' that is orthog specific. Each node is a COG group, with information on the functional annotation  and the input proteins present in each ortholog group. there 
#' are lines connecting interaction scores 
#' @param proteins A list that contains a sequence of NCBI/Genbank protein ids
#' @param benchmark Set benchmarks for association scores
#' @return graph of interaction network 
#' @keywords interaction network 
#' @importFrom igraph make_empty_graph
#' @importFrom igraph vcount
#' @importFrom igraph set_vertex_attr
#' @importFrom igraph add_edges
#' @importFrom igraph set_edge_attr
#' @importFrom igraph plot.igraph
#' @importFrom igraph vertex_attr
#' @importFrom utils data
#' @export

OrthologNetwork <- function(proteins,benchmark=0){
  orthologs <- GetOrthology(proteins)
  orthos <- unique(orthologs$COGID)
  OgGraph = make_empty_graph(n=length(orthos))
  annotations <- FunctionalAnnotation(orthos)
  CogLinks <- CogLinker(orthos,benchmark)
  vercount <- vcount(OgGraph)
  for(x in 1:vercount) {
    OgGraph <- set_vertex_attr(OgGraph,"ortholog", index=x,value = orthos[x])
    OgGraph <- set_vertex_attr(OgGraph,"description",index=x,value= annotations$description[x])
  }
  # add edges
  if (length(CogLinks$association_score > 0)){
    for(j in 1:nrow(CogLinks)) {
      row <- CogLinks[j,]
      if (!is.na(row$group1)) {
        FirstGroupIndex <- which(vertex_attr(OgGraph,"ortholog") %in% row$group1)
        SecondGroupIndex <- which(vertex_attr(OgGraph,"ortholog") %in% row$group2)
        for (item in FirstGroupIndex) {
          for (NextItem in SecondGroupIndex) {
            OgGraph <- add_edges(OgGraph, c(item,NextItem))
            OgGraph <- set_edge_attr(OgGraph,"link", value=row$association_score)
          }
        }
      }
    }
  }
  plot.igraph(OgGraph,vertex.label=orthos,vertex.size=40,vertex.colour="red",edge.arrow.mode="-")
  return(OgGraph)
}
