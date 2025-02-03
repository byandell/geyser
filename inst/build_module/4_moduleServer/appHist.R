library(geyser)

appUI <- bslib::page(
  histInput(id = "hist"), 
  histOutput(id = "hist"),
  histUI(id = "hist")
)
appServer <- function(input, output, session) {
  histServer(id = "hist")
}
shiny::shinyApp(appUI, appServer)

