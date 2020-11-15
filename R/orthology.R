#' The Get Orthology Function 
#' 
#' This function retrieves the corresponding ortholog groups for the input set of proteins, by retrieving 
#' their ortholog groups and that orthologs members (derived from EGGNOG Database)
#' @param classifiers A list that contains a sequence of protein/genes classifiers 
#' @return dictionary containing the orthologous groups present in the input sequence, and their respective members 
#' @keywords orthology 
#' @export
#' @examples
#' \dontrun {
#' get_orthology([Gene1,Gene2,Gene3])
#' }
#' {Gene1: Group X, Gene2: Group Y, Gene3: Group Z}

get_orthology <- function(classifiers){
  for (i in classifiers) {
    firstchar <- paste("SELECT COGID FROM orthos where GenBankID=",i,sep = "'")
    secondchar <-paste(firstchar,"",sep = "'")
    query <- sqldf(secondchar,orthos)
    if (length(query$COGID) == 0) {
    print(paste("Classifier",i,"does not belong to any group",sep=" "))}
    else{
      for(result in query$COGID) {
        print(paste("Classifier",i,"belongs to the group",result,sep = " "))
      }
      }
  }
}
  