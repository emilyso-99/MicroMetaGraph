#' The Get Orthology Function 
#' 
#' This function retrieves the corresponding ortholog groups for the input set of proteins, by retrieving 
#' their ortholog groups and that orthologs members (derived from EGGNOG Database)
#' @param classifiers A list that contains a sequence of protein/genes classifiers 
#' @return dataframe containing the orthologous groups present in the input 
#' sequence, and their respective ortholog groups 
#' @keywords orthology 
#' @export
#' @importFrom tibble add_row
#' @import sqldf 
#' @importFrom utils data
#' @export
#' @examples
#' {
#' GetOrthology(c("644223.PAS_chr1-1_0187","5270.UM01492.1","51453.JGI55417"))
#' }
#' "Protein with ID 644223.PAS_chr1-1_0187 belongs to the group COG5271"
#' "Protein with ID 5270.UM01492.1 belongs to the group COG0515"
#' "Protein with ID 51453.JGI55417 belongs to the group COG5245"

GetOrthology <- function(classifiers){
  CogDf <- data.frame(COGID=character(),EggnogID = character())
  for (i in classifiers) {
    firstchar <- paste("SELECT COGID FROM OrthologsData where EggnogID=",i,sep = "'")
    secondchar <-paste(firstchar,"",sep = "'")
    query <- sqldf(secondchar,OrthologsInfo)
    if (length(query$COGID) == 0) {
    print(paste("Protein with ID",i,"does not belong to any group",sep=" "))
    CogDf <- tibble::add_row(CogDf,COGID ="None",EggnogID=i)}
    else{
      for(result in query$COGID) {
        print(paste("Protein with ID",i,"belongs to the group",result,sep = " "))
        CogDf <- add_row(CogDf,COGID=result,EggnogID=i)
      }
      }
  }
  #get rid of first row 
  return(CogDf)
}
  
