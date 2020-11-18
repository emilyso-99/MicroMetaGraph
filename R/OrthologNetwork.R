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
#' ProteinNetwork([Protein X])
#' }
#'

OrthologNetwork <- function(proteins,benchmark){
  orthologs <- GetOrthology(proteins)
  orthos <- unique(orthologs$OG)
  print("orthos")
  print(orthos)
  OgGraph = make_empty_graph(n=length(orthos))
  annotations <- FunctionalAnnotation(orthos)
  CogLinks <- CogLinker(orthos,benchmark)
  for(x in 1:vcount(OgGraph)) {
    OgGraph <- set_vertex_attr(OgGraph,"ortholog", index=x,value = orthos[x])
    OgGraph <- set_vertex_attr(OgGraph,"description",index=x,value= annotations$description[x])
  }
  # add edges
  if (length(CogLinks$association_score > 0)){
    for(j in 1:nrow(CogLinks)) {
      row <- CogLinks[j,]
      if (!is.na(row$group1)) {
        firstgroupindex <- which(vertex_attr(OgGraph,"ortholog") %in% row$group1)
        secondgroupindex <- which(vertex_attr(OgGraph,"ortholog") %in% row$group2)
        for (item in firstgroupindex) {
          for (next_item in secondgroupindex) {
            print(c(item,next_item))
            OgGraph <- add_edges(OgGraph, c(item,next_item))
            OgGraph <- set_edge_attr(OgGraph,"link", value=row$association_score)
          }
        }
      }
    }
  }
  plot.igraph(OgGraph,vertex.label=orthos,vertex.size=40,vertex.colour="red",edge.arrow.mode="-")
  return(OgGraph)
}
