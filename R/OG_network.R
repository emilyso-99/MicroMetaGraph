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

ortholog_network <- function(proteins,benchmark){
  orthologs <- get_orthology(proteins)
  orthos <- unique(orthologs$OG)
  print("orthos")
  print(orthos)
  OG_graph = make_empty_graph(n=length(orthos))
  annotations <- functional_annotation(orthos)
  cog_links <- cog_linker(orthos,benchmark)
  for(x in 1:vcount(OG_graph)) {
    print("This is x")
    print(x)
    OG_graph <- set_vertex_attr(OG_graph,"ortholog", index=x,value = orthos[x])
    OG_graph <- set_vertex_attr(OG_graph,"description",index=x,value= annotations$description[x])
  }
  # add edges
  print(cog_links)
  if (length(cog_links$association_score > 0)){
    for(j in seq_along(cog_links)) {
      row <- cog_links[j,]
      if (!is.na(row$group1)) {
        print(vertex_attr(OG_graph,"ortholog"))
        firstgroup_index <- which(vertex_attr(OG_graph,"ortholog") %in% row$group1)
        secondgroupindex <- which(vertex_attr(OG_graph,"ortholog") %in% row$group2)
        print(firstgroup_index)
        print(secondgroupindex)
        for (item in firstgroup_index) {
          for (next_item in secondgroupindex) {
            OG_graph <- add_edges(OG_graph, c(item,next_item))
            OG_graph <- set_edge_attr(OG_graph,"link", value=row$association_score)
            
          }
        }
      }
    }
  }
  return(OG_graph)
}