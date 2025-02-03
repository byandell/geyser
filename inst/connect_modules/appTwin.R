# context: setup
library(geyser)

# context: ui
ui <- bslib::page(
  title = "Geyser Twin Histogram Modules",
  bslib::layout_columns(
    bslib::card(bslib::card_header("hist1"),
                histInput("hist1"), 
                histOutput("hist1"),
                histUI("hist1")),
    bslib::card(bslib::card_header("hist2"),
                histInput("hist2"), 
                histOutput("hist2"),
                histUI("hist2")))
)

# context: server
server <- function(input, output, session) {
  histServer("hist1")
  histServer("hist2")
}
shiny::shinyApp(ui, server)
