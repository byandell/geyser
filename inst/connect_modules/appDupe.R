# context: setup
library(geyser)

# context: ui
ui <- bslib::page(
  title = "Geyser Duplicate Histogram Modules",
  bslib::layout_columns(
    bslib::card(bslib::card_header("hist1"),
                histInput("hist"), 
                histOutput("hist"),
                histUI("hist")),
    bslib::card(bslib::card_header("hist2"),
                histInput("hist"), 
                histOutput("hist"),
                histUI("hist")))
)

# context: server
server <- function(input, output, session) {
  histServer("hist")
  histServer("hist")
}
shiny::shinyApp(ui, server)
