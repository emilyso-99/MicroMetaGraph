#' The Annotation Function 
#' 
#' This function retrieves the corresponding ortholog groups for the input set of proteins, by retrieving 
#' their ortholog groups and that orthologs members (derived from EGGNOG Database)
#' @param classifiers A list that contains a sequence of orthologs
#' @return dataframe containing the functional annotations for each ortholog group 
#' @keywords functional annotation 
#' @export
#' @importFrom tibble add_row
#' @import sqldf
#' @importFrom utils data
#' @export
#' @examples
#'{
#' FunctionalAnnotation(c("COG0001"))
#' }
#' "The group COG0001 has the functional assignment
#'  H which is associated with the functional description: 
#'  Coenzyme transport and metabolism"

FunctionalAnnotation <- function(classifiers){
  OG_category <- tibble(OG=character(),description=character())
  for (i in classifiers) {
    firstchar <- paste("SELECT category FROM AnnotationData where COG_ID=",i,sep = "'")
    secondchar <-paste(firstchar,"",sep = "'")
    query <- sqldf(secondchar,AnnotationData)
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
