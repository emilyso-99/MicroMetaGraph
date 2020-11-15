#' The Annotation Function 
#' 
#' This function retrieves the corresponding ortholog groups for the input set of proteins, by retrieving 
#' their ortholog groups and that orthologs members (derived from EGGNOG Database)
#' @param classifiers A list that contains a sequence of orthologs
#' @return dataframe containing the functional annotations for each ortholog group 
#' @keywords functional annotation 
#' @export
#' @examples
#' \dontrun {
#' get_orthology([Group X])
#' }
#' The Group X has the functional assignment A which is associated with the functional description: DNA Repair

functional_annotation <- function(classifiers){
  for (i in classifiers) {
    OG_category <- tibble(OG=NA,description=NA)
    firstchar <- paste("SELECT category FROM OG_categories where COG_ID=",i,sep = "'")
    secondchar <-paste(firstchar,"",sep = "'")
    query <- sqldf(secondchar,OG_categories)
    categoryfirst <- paste("SELECT description FROM categories where letter=",query$category,sep = "'")
    categorysecond <- paste(firstchar,"",sep = "'")
    secondquery <- sqldf(categorysecond,categories)
    OG_category <- add_row(OG_category,OG=i,description=secondquery$description)
    print(paste("The group",i,"has the functional assignment",query$category,"which is associated with the functional description:",secondquery$description,sep = " "))
  }
  return(OG_category)
}
