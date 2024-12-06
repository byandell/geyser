devtools::install_github("byandell/geyser")

ui <- shiny::navbarPage(
  "Geyser Modules with NavBar, Brian Yandell",
  shiny::tabPanel("hist",
    geyser::histInput("hist"), 
    geyser::histOutput("hist"),
    geyser::histUI("hist")
  ),
  shiny::tabPanel("gghist",
    geyser::gghistInput("gghist"), 
    geyser::gghistOutput("gghist"),
    geyser::gghistUI("gghist")
  ),
  shiny::tabPanel("ggpoint",
    geyser::ggpointInput("ggpoint"), 
    geyser::ggpointOutput("ggpoint"),
    geyser::ggpointUI("ggpoint")
  ),
  shiny::tabPanel("Rows",
    shiny::titlePanel("Geyser Rows Modules"),
    geyser::rowsUI("rows")
  ),
  shiny::tabPanel("Switch",
    shiny::titlePanel("Geyser Switch Modules"),
    geyser::switchInput("switch"), 
    geyser::switchUI("switch"),
    geyser::switchOutput("switch")
  )
)

server <- function(input, output, session) {
  geyser::histServer("hist")
  geyser::gghistServer("gghist")
  geyser::ggpointServer("ggpoint")
  
  geyser::rowsServer("rows")
  
  geyser::switchServer("switch")
}
shiny::shinyApp(ui, server)