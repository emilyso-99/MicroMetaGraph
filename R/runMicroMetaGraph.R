#' Launch Shiny App For Package MicroMetaGraph
#'
#' A function that launches the shiny app for this package.
#' The shiny app permit to perform clustering using mixtures
#' of MPLN via variational-EM. Model selection is performed
#' using AIC, AIC3, BIC and ICL.
#'
#' @return No return value but open up a shiny page.
#'
#' @examples
#' \dontrun{
#' runMicroMetaGraph()
#' }
#'
#' @author Emily So , \email{emily.so@mail.utoronto.ca}
#'
#' @export
#' @importFrom shiny runApp
runMicroMetaGraph <- function() {
  appDir <- system.file("shinyapp",
                        package = "MicroMetaGraph")
  print(appDir)
  shiny::runApp(appDir, display.mode = "normal")
  return()
}