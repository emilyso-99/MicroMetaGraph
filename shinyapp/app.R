library(shiny)
load_all("../R")
# Define UI for random distribution app ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Tabsets"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Select the random distribution type ----
      radioButtons("plot", "Graph type:",
                   c("Orthologs" = "orth",
                     "Protein" = "prot")),
      
      # br() element to introduce extra vertical spacing ----
      br(),
      
      # Input: Slider for the number of observations to generate ----
      textInput("text",
                  h3("Text Input"),
                 value = "CSAL_RS12960,KRAD_RS18185,MPE_RS01260,NH8B_RS05620,RIV7116_RS09085")
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Tabset w/ plot, summary, and table ----
      tabsetPanel(type = "tabs",
                  tabPanel("Network", plotOutput("plot")),
                  tabPanel("Summary", verbatimTextOutput("summary")),
                  tabPanel("Orthologs", tableOutput("ogs")),
                  tabPanel("Functional Annotation", tableOutput("annotation")),
                  tabPanel("Links", tableOutput("links"))
      )
      
    )
  )
)

# Define server logic for random distribution app ----
server <- function(input, output) {
  # Reactive expression to generate the requested distribution ----
  # This is called whenever the inputs change. The output functions
  # defined below then use the value computed from this expression
  network <- reactive({
    print("Please allow the serve a minute to generate output")
    x <- unlist(strsplit(input$text,","))
    if (input$plot == "orth") {
      OrthologNetwork(x)
    }
    else {
      ProteinNetwork(x)
      
    }
  })
  orthologs <- reactive({
    print("Please allow the serve a minute to generate output")
    x <- unlist(strsplit(input$text,","))
    GetOrthology(x)
  })
  links <- reactive({
    print("Please allow the shiny app a minute to generate output")
    x <- unlist(strsplit(input$text,","))
    OGs <- invisible(capture.output(GetOrthology(x)))
    CogLinker(OGs$OG)
  })
  annotations <- reactive({
    print("Please allow the shiny app a minute to generate output")
    x <- unlist(strsplit(input$text,","))
    OGs <- invisible(capture.output(GetOrthology(x)))
    FunctionalAnnotation(OGs$OG)
  })
  # Generate a plot of the data ----
  # Also uses the inputs to build the plot label. Note that the
  # dependencies on the inputs and the data reactive expression are
  # both tracked, and all expressions are called in the sequence
  # implied by the dependency graph.
  output$plot <- renderPlot({
    plot.igraph(network())
  })
  
  # Generate a summary of the data ----
  output$summary <- renderPrint({
    x <- unlist(strsplit(input$text,","))
    capture.output(ProteinNetwork(x))
  })
  
  # Generate an HTML table view of the data ----
  output$ogs <- renderTable({
    invisible(orthologs())
  })
  output$annotation <- renderTable({
    invisible(annotations())
  })
  output$links <- renderTable({
    invisible(links())
  })
}

# Create Shiny app ----
shinyApp(ui, server)