library(shiny)

modular <- readline("Enter yes to use modules or no otherwise: ")
modular <- !is.na(pmatch(modular, "yes"))

if(modular) {
  source("shinyapp.R") 
} else {
  source("geyserapp.R")
}

ui <- geyserUI()

if(modular) {
  server <- function(input, output, session) {
    shiny::callModule(geyserServer, "geyser")
  }
} else {
  server <- function(input, output, session) {
    geyserServer(input, output)
  }
}

shiny::shinyApp(ui = ui, server = server)
