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
#' GetOrthology([Group X])
#' }
#' The Group X has the functional assignment A which is associated with the functional description: DNA Repair

FunctionalAnnotation <- function(classifiers){
  OG_category <- tibble(OG=character(),description=character())
  for (i in classifiers) {
    firstchar <- paste("SELECT category FROM og_annotation where COG_ID=",i,sep = "'")
    secondchar <-paste(firstchar,"",sep = "'")
    query <- sqldf(secondchar,OG_categories)
    categoryfirst <- paste("SELECT Description FROM categories where Letter=",query$category,sep = "'")
    categorysecond <- paste(categoryfirst,"",sep = "'")
    secondquery <- sqldf(categorysecond,categories)
    if (length(secondquery$Description) == 0) {
      OG_category <- add_row(OG_category,OG=i,description="None")
      print(paste("The group",i,"has no functional assignment and therefore no description",sep = " "))
    }
    else {
    print(paste("The group",i,"has the functional assignment",query$category,"which is associated with the functional description:",secondquery$Description,sep = " "))}
    OG_category <- add_row(OG_category,OG=i,description=secondquery$Description)
  }
  return(OG_category)
}
