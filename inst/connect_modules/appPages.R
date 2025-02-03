# context: setup
source("../../R/hist.R")
source("../../R/gghist.R")
source("../../R/ggpoint.R")

# context: ui
ui <- bslib::page_navbar(
  title = "Geyser Modules with NavBar",
  bslib::nav_panel("hist",
                  histInput("hist"), 
                  histOutput("hist"),
                  histUI("hist")
  ),
  bslib::nav_panel("gghist",
                  gghistInput("gghist"), 
                  gghistOutput("gghist"),
                  gghistUI("gghist")
  ),
  bslib::nav_panel("ggpoint",
                  ggpointInput("ggpoint"), 
                  ggpointOutput("ggpoint"),
                  ggpointUI("ggpoint")
  )
)

# context: server
server <- function(input, output, session) {
  histServer("hist")
  gghistServer("gghist")
  ggpointServer("ggpoint")
}
shiny::shinyApp(ui, server)
