#' The Get Orthology Function 
#' 
#' This function retrieves the corresponding ortholog groups for the input set of proteins, by retrieving 
#' their ortholog groups and that orthologs members (derived from EGGNOG Database)
#' @param classifiers A list that contains a sequence of protein/genes classifiers 
#' @return dataframe containing the orthologous groups present in the input sequence, and their respective ortholog groups 
#' @keywords orthology 
#' @export
#' @examples
#' \dontrun {
#' get_orthology([Gene1,Gene2,Gene3])
#' }
#' {Gene1: Group X, Gene2: Group Y, Gene3: Group Z}

get_orthology <- function(classifiers){
  cog_df <- data.frame(GenBankID=character(),OG = character())
  for (i in classifiers) {
    firstchar <- paste("SELECT COGID FROM orthologs_info where GenBankID=",i,sep = "'")
    secondchar <-paste(firstchar,"",sep = "'")
    query <- sqldf(secondchar,COG_orthos)
    if (length(query$COGID) == 0) {
    print(paste("Protein with GenBank ID",i,"does not belong to any group",sep=" "))
    cog_df <- add_row(cog_df,GenBankID=i,OG="None")}
    else{
      for(result in query$COGID) {
        print(paste("Protein with GenBank ID",i,"belongs to the group",result,sep = " "))
        cog_df <- add_row(cog_df,GenBankID=i,OG=result)
      }
      }
  }
  #get rid of first row 
  return(cog_df)
}
  