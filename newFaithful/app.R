# New Faithful with shiny content in functions
# geyser/newFaithful/app.R

source("newFaithful.R")

ui <- fakeUI()
server <- fakeServer

shiny::shinyApp(ui = ui, server = server)
