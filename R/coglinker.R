#' The Annotation Function 
#' 
#' This function, when fed a character vector of ortholog groups, will return the bit scores of the other COG groups in the datasets that it interacts with
#' @param groups A character vector that contains a list of OGs, benchmark for association score
#' @return dataframe containing each pair of OGs with its bitscore  
#' @keywords functional annotation 
#' @export
#' @examples
#' \dontrun {
#' CogLinker(c("COG0001","COG0002"),100)
#' }
#'"Classifier COG0002 connects with the group COG0001"

CogLinker <- function(groups,benchmark){
  linker <- tibble(group1=character(),group2=character(),association_score=numeric())
  for (i in groups) {
    firstchar <- paste("SELECT * FROM CogLinks where group1=",i,sep = "'")
    secondchar <-paste(firstchar," and association_score >",sep = "'")
    thirdchar <- paste(secondchar,as.character(benchmark),sep =" ")
    query <- sqldf(thirdchar,CogLinks)
    if (nrow(query) == 0) {
      print(paste("Classifier",i,"does not associate with any COG",sep=" "))
      linker <- add_row(linker,group1=i,group2="None",association_score=0)
    }
    else{
      for(j in 1:nrow(query)) {
        row <- query[j,]
        indx <- which(groups %in% row$group2)
        if (length(indx) >= 1) {
        print(paste("Classifier",i,"connects with the group",row$group2,sep=" "))
        linker <- add_row(linker,group1=i,group2=row$group2,association_score=row$association_score)}
      }
    }
    }
  return(linker)
}

