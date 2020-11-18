#' The Protein Network Function 
#' 
#' from beginning to end, using the query functions that were done before, this function constructs a protein interaction network 
#' that is protein-specific-each node is a protein, with information on the functional annotation and the ortholog group. there 
#' are lines connecting interactoin scores 
#' @param classifiers A list that contains a sequence of NCBI/Genbank protein ids
#' @return graph of interaction network 
#' @keywords interaction network 
#' @export
#' @examples
#' ProteinNetwork(c("M164_1961","RGE_RS00290"),100)
#'"Classifier COG0001 connects with the group COG0002"
#'"Classifier COG0002 connects with the group COG0001"
#'IGRAPH 85c90cf D--- 2 2 -- 
#'attr: protein (v/c), ortholog (v/c), description (v/c), link (e/n)
#'edges from 85c90cf:
#'1->2 2->1

ProteinNetwork <- function(proteins,benchmark=0){
# get orthology data 
ProteinGraph = make_empty_graph(n=length(proteins))
orthologs <- GetOrthology(proteins)
annotations <- FunctionalAnnotation(orthologs$OG)
CogLinks <- CogLinker(orthologs$OG,benchmark)
for(x in 1:vcount(ProteinGraph)) {
ProteinGraph <- set_vertex_attr(ProteinGraph,"protein",index=x,value=proteins[x])
ProteinGraph <- set_vertex_attr(ProteinGraph,"ortholog", index=x,value = orthologs$OG[x])
ProteinGraph <- set_vertex_attr(ProteinGraph,"description",index=x,value= annotations$description[x])
}
# add edges
if (length(CogLinks$association_score > 0)){
for(j in 1:nrow(CogLinks)) {
  row <- CogLinks[j,]
  if (!is.na(row$group1)) {
  firstgroup_index <- which(vertex_attr(ProteinGraph,"ortholog") %in% row$group1)
  secondgroupindex <- which(vertex_attr(ProteinGraph,"ortholog") %in% row$group2)
  for (item in firstgroup_index) {
    for (next_item in secondgroupindex) {
      ProteinGraph <- add_edges(ProteinGraph, c(item,next_item))
      ProteinGraph <- set_edge_attr(ProteinGraph,"link", value=row$association_score)
    }
  }
  }
}
}
plot.igraph(ProteinGraph,vertex.label=proteins,vertex.size=50,vertex.colour="red",edge.arrow.mode="-")
return(ProteinGraph)
}
