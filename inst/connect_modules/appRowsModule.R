# context: setup
library(geyser)

# context: ui
ui <- bslib::page(
  title = "Geyser Rows Modules",
  rowsInput("rows"),
  rowsUI("rows")
)

# context: server
server <- function(input, output, session) {
  rowsServer("rows")
}
shiny::shinyApp(ui, server)
