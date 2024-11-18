# New Faithful with shiny content in functions
# geyser/newFaithful/app.R

source("functions")

ui <- geyserUI()
server <- geyserServer

shiny::shinyApp(ui = ui, server = server)
