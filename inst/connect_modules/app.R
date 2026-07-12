# context: setup
pak::pak("geyser")
library(geyser)

# context: ui
ui <- bslib::page_navbar(
  title = "Geyser Modules with NavBar, Brian Yandell",
  bslib::nav_panel(
    "hist",
    histInput("hist"),
    histOutput("hist"),
    histUI("hist")
  ),
  bslib::nav_panel(
    "gghist",
    gghistInput("gghist"),
    gghistOutput("gghist"),
    gghistUI("gghist")
  ),
  bslib::nav_panel(
    "ggpoint",
    ggpointInput("ggpoint"),
    ggpointOutput("ggpoint"),
    ggpointUI("ggpoint")
  ),
  bslib::nav_panel(
    "Rows",
    shiny::titlePanel("Geyser Rows Modules"),
    rowsInput("rows"),
    rowsUI("rows")
  ),
  bslib::nav_panel(
    "Switch",
    shiny::titlePanel("Geyser Switch Modules"),
    switchInput("switch"),
    switchOutput("switch"),
    switchUI("switch")
  )
)

# context: server
server <- function(input, output, session) {
  histServer("hist")
  gghistServer("gghist")
  ggpointServer("ggpoint")

  rowsServer("rows")

  switchServer("switch")
}
shiny::shinyApp(ui, server)
