# Call Module with shiny content in component functions
# geyser/callModule/appModule.R

# Uses new (2020) style `moduleServer`.
# Retains function `geyserCall` with old style to show transition.
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
  # Function `moduleServer` returns a new function.
  shiny::moduleServer(id = "geyser",
    function(input, output, session) geyserCall(input,output,session))

shiny::shinyApp(ui = ui, server = server)
