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
#' \dontrun {
#' protein_network([Protein X])
#' }
#'

protein_network <- function(proteins,benchmark){
# get orthology data 
protein_graph = make_empty_graph(n=length(proteins))
orthologs <- get_orthology(proteins)
annotations <- functional_annotation(orthologs$OG)
print(annotations)
cog_links <- cog_linker(orthologs$OG,benchmark)
for(x in 1:vcount(protein_graph)) {
protein_graph <- set_vertex_attr(protein_graph,"protein",index=x,value=proteins[x])
protein_graph <- set_vertex_attr(protein_graph,"ortholog", index=x,value = orthologs$OG[x])
protein_graph <- set_vertex_attr(protein_graph,"description",index=x,value= annotations$description[x])
}
print(orthologs)
# add edges
print(cog_links)
if (length(cog_links$association_score > 0)){
for(j in seq_along(cog_links)) {
  row <- cog_links[j,]
  if (!is.na(row$group1)) {
  print(row$group1)
  print(vertex_attr(protein_graph,"ortholog"))
  print(vertex_attr(protein_graph,"ortholog") %in% row$group1)
  firstgroup_index <- which(vertex_attr(protein_graph,"ortholog") %in% row$group1)
  secondgroupindex <- which(vertex_attr(protein_graph,"ortholog") %in% row$group2)
  print(firstgroup_index)
  print(secondgroupindex)
  for (item in firstgroup_index) {
    for (next_item in secondgroupindex) {
      protein_graph <- add_edges(protein_graph, c(item,next_item))
      protein_graph <- set_edge_attr(protein_graph,"link", value=row$association_score)
      
    }
  }
  }
}
}
return(protein_graph)
}