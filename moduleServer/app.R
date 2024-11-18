# moduleServer style Shiny Module
# geyser/moduleServer/app.R

# This uses the `id` argument to connect UI and Server components.
# New (>=2020) style: `moduleServer`
# Function `geyserServer` is function that creates a `server` function.
# See <https://mastering-shiny.org/scaling-modules.html>

source("moduleServer.R")

ui <- shiny::bootstrapPage(
  geyserInput("geyser"), 
  geyserOutput("geyser"),
  # Display this only if the density is shown
  geyserUI("geyser")
)
server <- function(input, output, session) {
  geyserServer("geyser")
}
shiny::shinyApp(ui, server)

