# context: setup
library(geyser)

# context: ui
ui <- shiny::fluidPage(
  # context: ui
  shiny::titlePanel("Geyser Rows Modules in Shiny, Brian Yandell"),
  rowsInput("rows"),
  rowsUI("rows")
)

# context: server
server <- function(input, output, session) {
  rowsServer("rows")
}
shiny::shinyApp(ui, server)
