library(geyser)

app_ui <- shiny::bootstrapPage(
  histInput(id = "hist"), 
  histOutput(id = "hist"),
  histUI(id = "hist")
)
app_server <- function(input, output, session) {
  histServer(id = "hist")
}
shiny::shinyApp(app_ui, app_server)

