# Old and (Almost) New Modular Structure 
# geyser/modular/app.R

# This uses the `id` argument to connect UI and Server components.
# Old (<2020) style:  `callModule`
# New (>=2020) style: `moduleServer`
# Function `geyserServer` is set up for old style
# See <https://mastering-shiny.org/scaling-modules.html>

source("shinyapp.R")
ui <- shiny::bootstrapPage(
  geyserInput("geyser"), 
  geyserOutput("geyser"),
  # Display this only if the density is shown
  geyserUI("geyser")
)

modular <- readline("callModule (1) or moduleServer (2):")

if(modular == 1) { # Use old-style `callModule`
  server <- function(input, output, session) {
    shiny::callModule(geyserServer, "geyser")
  }
} else { # Use new-style `moduleServer`
  server <- function(input, output, session)
    shiny::moduleServer("geyser",
      function(input, output, session) geyserServer(input,output,session))
}

shiny::shinyApp(ui = ui, server = server)
