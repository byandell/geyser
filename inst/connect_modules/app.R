devtools::install_github("byandell/geyser")

ui <- shiny::navbarPage(
  "Geyser Modules with NavBar, Brian Yandell",
  shiny::tabPanel(
    "Rows",
    shiny::titlePanel("Geyser Rows Modules in Shiny, Brian Yandell"),
    shiny::fluidRow(
      shiny::column(6, geyser::datasetsInput("datasets")),
      shiny::column(6, geyser::datasetsUI("datasets"))
    ),
    shiny::fluidRow(
      shiny::column(4, shiny::tagList(
        shiny::titlePanel("hist"),
        geyser::histInput("hist"), 
        geyser::histOutput("hist"),
        geyser::histUI("hist")
      )),
      shiny::column(4, shiny::tagList(
        shiny::titlePanel("gghist"),
        geyser::gghistInput("gghist"), 
        geyser::gghistOutput("gghist"),
        geyser::gghistUI("gghist")
      )),
      shiny::column(4, shiny::tagList(
        shiny::titlePanel("ggpoint"),
        geyser::ggpointInput("ggpoint"), 
        geyser::ggpointOutput("ggpoint"),
        geyser::ggpointUI("ggpoint")
      ))
    )),
  shiny::tabPanel(
    "Wrapper",
    geyser::wrappersetInput("wrapperset"), 
    geyser::wrappersetUI("wrapperset"),
    geyser::wrappersetOutput("wrapperset")
  )
)

server <- function(input, output, session) {
  dataset <- geyser::datasetsServer("datasets")
  geyser::histServer("hist", dataset)
  geyser::gghistServer("gghist", dataset)
  geyser::ggpointServer("ggpoint", dataset)

  geyser::wrappersetServer("wrapperset")
}
shiny::shinyApp(ui, server)