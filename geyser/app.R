# geyser current best practice
source("geyser.R")

ui <- shiny::bootstrapPage(
  geyserInput("geyser"), 
  geyserOutput("geyser"),
  # Display this only if the density is shown
  geyserUI("geyser")
)
server <- function(input, output, session) {
  geyserServer("geyser")
}
shiny::shinyApp(ui, server)

