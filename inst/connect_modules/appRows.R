# context: setup
library(geyser)

# context: ui
ui <- bslib::page(
  title = "Geyser Rows Modules",
  bslib::layout_columns(
    datasetsInput("datasets"),
    datasetsUI("datasets")),
  bslib::layout_columns(
    bslib::card(bslib::card_header("hist"),
                histInput("hist"), 
                histOutput("hist"),
                histUI("hist")),
    bslib::card(bslib::card_header("gghist"),
                gghistInput("gghist"), 
                gghistOutput("gghist"),
                gghistUI("gghist")),
    bslib::card(bslib::card_header("ggpoint"),
                ggpointInput("ggpoint"), 
                ggpointOutput("ggpoint"),
                ggpointUI("ggpoint")))
)

# context: server
server <- function(input, output, session) {
  dataset <- datasetsServer("datasets")
  histServer("hist", dataset)
  gghistServer("gghist", dataset)
  ggpointServer("ggpoint", dataset)
}
shiny::shinyApp(ui, server)
