# faithful original structure
source("faithfulapp.R")

ui <- geyserUI()

if(modular == 1) {
  server <- function(input, output, session) {
    shiny::callModule(geyserServer, "geyser")
  }
} else {
  server <- function(input, output, session) {
    geyserServer(input, output)
  }
}

shiny::shinyApp(ui = ui, server = server)

