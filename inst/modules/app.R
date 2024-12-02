# context: setup
source("../R/hist.R")

ui <- shiny::bootstrapPage(
  histInput("hist"), 
  histOutput("hist"),
  histUI("hist")
)
server <- function(input, output, session) {
  histServer("hist")
}
shiny::shinyApp(ui, server)
