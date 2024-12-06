devtools::install_github("byandell/geyser")

ui <- shiny::navbarPage(
  "Geyser Modules with NavBar, Brian Yandell",
  shiny::tabPanel("hist",
                  histInput("hist"), 
                  histOutput("hist"),
                  histUI("hist")
  ),
  shiny::tabPanel("gghist",
                  gghistInput("gghist"), 
                  gghistOutput("gghist"),
                  gghistUI("gghist")
  ),
  shiny::tabPanel("ggpoint",
                  ggpointInput("ggpoint"), 
                  ggpointOutput("ggpoint"),
                  ggpointUI("ggpoint")
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
  histServer("hist")
  gghistServer("gghist")
  ggpointServer("ggpoint")
  
  geyser::rowsServer("rows")
  
  geyser::switchServer("switch")
}
shiny::shinyApp(ui, server)