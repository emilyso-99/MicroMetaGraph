#' The Annotation Function 
#' 
#' This function, when fed a character vector of ortholog groups, will return the bit scores of the COG group associations 
#' @param groups A character vector that contains a list of OGs, benchmark for association score
#' @return dataframe containing each pair of OGs with its bitscore  
#' @keywords functional annotation 
#' @export
#' @examples
#' \dontrun {
#' get_orthology([Group X])
#' }
#' The Group X pairs with Group Y with a bit score of 248

cog_linker <- function(groups,benchmark){
  linker <- tibble(group1=character(),group2=character(),association_score=numeric())
  for (i in groups) {
    firstchar <- paste("SELECT * FROM cog_links where group1=",i,sep = "'")
    secondchar <-paste(firstchar," and association_score >",sep = "'")
    thirdchar <- paste(secondchar,as.character(benchmark),sep =" ")
    query <- sqldf(thirdchar,cog_links)
      for(j in seq_along(query$group2)) {
        row <- query[j,]
        if (length(row$group2) == 0) {
          print(paste("Classifier",i,"does not associate with any COG",sep=" "))
          linker <- add_row(linker,group1=i,group2=NA,association_score=0)}
        else{
        indx <- which(groups %in% row$group2)
        if (length(indx) >= 1) {
        print(paste("Classifier",i,"connects with the group",row$group2,sep=" "))
        linker <- add_row(linker,group1=i,group2=row$group2,association_score=row$association_score)}
        }
      }
    }
  return(linker)
}

