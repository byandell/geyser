devtools::install_github("byandell/geyser")

ui <- bslib::page_navbar(
  title = "Geyser Modules with NavBar, Brian Yandell",
  bslib::nav_panel("hist",
                   geyser::histInput("hist"), 
                   geyser::histOutput("hist"),
                   geyser::histUI("hist")
  ),
  shiny::tabPanel("gghist",
                  geyser::gghistInput("gghist"), 
                  geyser::gghistOutput("gghist"),
                  geyser::gghistUI("gghist")
  ),
  bslib::nav_panel("ggpoint",
                   geyser::ggpointInput("ggpoint"), 
                   geyser::ggpointOutput("ggpoint"),
                   geyser::ggpointUI("ggpoint")
  ),
  bslib::nav_panel("Rows",
                   shiny::titlePanel("Geyser Rows Modules"),
                   geyser::rowsInput("rows"),
                   geyser::rowsUI("rows")
  ),
  bslib::nav_panel("Switch",
                   shiny::titlePanel("Geyser Switch Modules"),
                   geyser::switchInput("switch"),
                   geyser::switchOutput("switch"), 
                   geyser::switchUI("switch")
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