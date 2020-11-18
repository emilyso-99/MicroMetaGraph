#' The Load Data Function 
#' 
#' This function is used to set up the pertaining databases in the package 
#' @param directory that the data is located in  
#' @keywords load,data 
#' @export
#' @examples
#' \dontrun {
#' load_data()
#' }
#'The data has been loaded!
#' 
#' 
load_data <- function(directory){
  setwd(directory)
  final_orthos <- load("./orthologues.rda")
  og_categories <- load("./og_categories.rda")
  categories <- load("./categories.rda")
  CogLinks <- load("./CogLinks.rda")
  print("the data has been loaded!")
  return(final_orthos,og_categories,categories,CogLinks)
}
  
