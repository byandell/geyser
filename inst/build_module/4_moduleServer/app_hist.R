library(geyser)

ui <- shiny::bootstrapPage(
  histInput(id = "hist"), 
  histOutput(id = "hist"),
  histUI(id = "hist")
)
server <- function(input, output, session) {
  histServer(id = "hist")
}
shiny::shinyApp(ui, server)

