# New Faithful with shiny content in functions
# geyser/newFaithful/app.R

# Use "fake" `ui` and `server` functions to _almost_ modularize code.

source("newFaithful.R")

shiny::shinyApp(ui = fakeUI(), server = fakeServer)
