# context: setup
library(geyser)

# context: ui
ui <- shiny::fluidPage(
  # context: ui
  shiny::titlePanel("Geyser Duplicate Histogram Modules, Brian Yandell"),
  shiny::fluidRow(
    shiny::column(4, shiny::tagList(
      shiny::titlePanel("hist1"),
      histInput("hist"), 
      histOutput("hist"),
      histUI("hist")
    )),
    shiny::column(4, shiny::tagList(
      shiny::titlePanel("hist2"),
      histInput("hist"), 
      histOutput("hist"),
      histUI("hist")
    ))
  )
)

# context: server
server <- function(input, output, session) {
  histServer("hist")
  histServer("hist")
}
shiny::shinyApp(ui, server)
