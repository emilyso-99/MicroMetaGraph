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
#' OrthologNetwork(c("M164_1961","RGE_RS00290"),100)
#' "The group COG0001 has the functional assignment H which is associated with the functional description: Coenzyme transport and metabolism"
#' "The group COG0002 has the functional assignment E which is associated with the functional description: Amino acid transport and metabolism"
#' "Classifier COG0001 connects with the group COG0002"
#' "Classifier COG0002 connects with the group COG0001"
#' IGRAPH 03b9c9c D--- 2 2 -- 
#' attr: ortholog (v/c), description (v/c), link (e/n)
#' edges from 03b9c9c:
#'

OrthologNetwork <- function(proteins,benchmark=0){
  orthologs <- GetOrthology(proteins)
  orthos <- unique(orthologs$OG)
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
