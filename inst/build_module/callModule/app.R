# Call Module with shiny content in component functions
# geyser/callModule/app.R

# Uses old (pre-2020) style `callModule`.
# Has function `geyserCall` with old style.
# Uses shiny `id` to connect serer components.
# See <https://mastering-shiny.org/scaling-modules.html>

source("callModule.R")

ui <- shiny::bootstrapPage(
  geyserInput(id = "geyser"), 
  geyserOutput(id = "geyser"),
  # Display this only if the density is shown
  geyserUI(id = "geyser")
)

server <- function(input, output, session)
  shiny::callModule(geyserCall, id = "geyser")

shiny::shinyApp(ui = ui, server = server)
