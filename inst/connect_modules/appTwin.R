# context: setup
library(geyser)

# context: ui
ui <- shiny::fluidPage(
  # context: ui
  shiny::titlePanel("Geyser Twin Histogram Modules, Brian Yandell"),
  shiny::fluidRow(
    shiny::column(4, shiny::tagList(
      shiny::titlePanel("hist1"),
      histInput("hist1"), 
      histOutput("hist1"),
      histUI("hist1")
    )),
    shiny::column(4, shiny::tagList(
      shiny::titlePanel("hist2"),
      histInput("hist2"), 
      histOutput("hist2"),
      histUI("hist2")
    ))
  )
)

# context: server
server <- function(input, output, session) {
  histServer("hist1")
  histServer("hist2")
}
shiny::shinyApp(ui, server)
