#' The Annotation Function 
#' 
#' This function, when fed a character vector of ortholog groups, will return the bit scores of the COG group associations 
#' @param groups A character vector that contains a list of OGs
#' @return dataframe containing each pair of OGs with its bitscore  
#' @keywords functional annotation 
#' @export
#' @examples
#' \dontrun {
#' get_orthology([Group X])
#' }
#' The Group X pairs with Group Y with a bit score of 248

cog_linker <- function(groups){
  for (i in groups) {
    firstchar <- paste("SELECT * FROM cog_links where group1=",i,sep = "'")
    secondchar <-paste(firstchar,"",sep = "'")
    query <- sqldf(secondchar,cog_links)
    if (length(query$group2) == 0) {
      print(paste("Classifier",i,"does not associate with any group",sep=" "))}
    else{
      for(result in query$group2) {
        print(paste("Classifier",i,"connects with the group",result,sep = " "))
      }
    }
  }
}

