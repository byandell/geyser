modular <- readline("Enter 1 = modular, 2 = faithful, 3 = geyserApp: ")
modular <- ifelse(is.na(modular), "3", modular)

switch(modular,
  "1" = source("shinyapp.R"),
  "2" = source("faithfulapp.R"),
  "3" = source("geyser.R"))

if(modular == "3") {
  geyserApp()
} else {
  
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
}
