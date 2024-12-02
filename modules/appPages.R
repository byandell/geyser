# context: setup
source("../R/hist.R")
source("../R/gghist.R")
source("../R/ggpoint.R")

ui <- shiny::navbarPage(
  "Geyser Modules with NavBar, Brian Yandell",
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
server <- function(input, output, session) {
  # context: server
  histServer("hist")
  gghistServer("gghist")
  ggpointServer("ggpoint")
}
shiny::shinyApp(ui, server)
