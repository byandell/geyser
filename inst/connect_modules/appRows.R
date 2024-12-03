# context: setup
library(geyser)

# context: ui
ui <- shiny::fluidPage(
  # context: ui
  shiny::titlePanel("Geyser Rows Modules in Shiny, Brian Yandell"),
  shiny::fluidRow(
    shiny::column(6, datasetsInput("datasets")),
    shiny::column(6, datasetsUI("datasets"))
  ),
  shiny::fluidRow(
    shiny::column(4, shiny::tagList(
      shiny::titlePanel("hist"),
      histInput("hist"), 
      histOutput("hist"),
      histUI("hist")
    )),
    shiny::column(4, shiny::tagList(
      shiny::titlePanel("gghist"),
      gghistInput("gghist"), 
      gghistOutput("gghist"),
      gghistUI("gghist")
    )),
    shiny::column(4, shiny::tagList(
      shiny::titlePanel("ggpoint"),
      ggpointInput("ggpoint"), 
      ggpointOutput("ggpoint"),
      ggpointUI("ggpoint")
    ))
  )
)

# context: server
server <- function(input, output, session) {
  dataset <- datasetsServer("datasets")
  histServer("hist", dataset)
  gghistServer("gghist", dataset)
  ggpointServer("ggpoint", dataset)
}
shiny::shinyApp(ui, server)
