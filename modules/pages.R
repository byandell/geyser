pagesApp <- function() {
  # context: setup
  source("R/hist.R")
  source("R/gghist.R")
  source("R/ggpoint.R")
  
  ui <- shiny::fluidPage(
    # context: ui
    shiny::titlePanel("Geyser Pages Modules in Shiny, Brian Yandell"),
    shiny::tabsetPanel(
      shiny::tabPanel("hist",
        histInput("hist"), 
        histOutput("hist"),
        histUI("hist")
      ),
      shiny::tabPanel("gghist",
        gghistInput("gghist"), 
        gghistOutput("gghist"),
        gghistUI("gghist")
      ),
      shiny::tabPanel("ggpoint",
        ggpointInput("ggpoint"), 
        ggpointOutput("ggpoint"),
        ggpointUI("ggpoint")
      )
    )
  )
  server <- function(input, output, session) {
    # context: server
    histServer("hist")
    gghistServer("gghist")
    ggpointServer("ggpoint")
  }
  shiny::shinyApp(ui, server)
}
