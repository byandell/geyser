# Call Module Components
# geyser/callModule/callModule.R

# Adds namespace `ns(inputId)` with `session$ns` in call and `NS(id)` in ui.
# Breaks up ui components by optional `Input`, `Output` and `UI`.
# Adds explicit dependence on packages `shiny`, `graphics` and `stats`.

geyserCall <- function(input, output, session) {
  ns <- session$ns
  
  output$main_plot <- shiny::renderPlot({
    graphics::hist(faithful$eruptions,
         probability = TRUE,
         breaks = as.numeric(input$n_breaks),
         xlab = "Duration (minutes)",
         main = "Geyser eruption duration")
    if (input$individual_obs) {
      graphics::rug(faithful$eruptions)
    }
    if (input$density) {
      shiny::req(input$bw_adjust)
      dens <- stats::density(faithful$eruptions, adjust = input$bw_adjust)
      graphics::lines(dens, col = "blue")
    }
  })
  
  output$bw_adjust <- shiny::renderUI({
    if(input$density) {
      shiny::sliderInput(inputId = ns("bw_adjust"),
                         label = "Bandwidth adjustment:",
                         min = 0.2, max = 2, value = 1, step = 0.2)
    }
  })
}

geyserInput <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::selectInput(inputId = ns("n_breaks"),
                       label = "Number of bins in histogram (approximate):",
                       choices = c(10, 20, 35, 50), selected = 20),
    shiny::checkboxInput(inputId = ns("individual_obs"),
                         label = strong("Show individual observations"),
                         value = FALSE),
    
    shiny::checkboxInput(inputId = ns("density"),
                         label = strong("Show density estimate"),
                         value = FALSE))
}
geyserOutput <- function(id) {
  ns <- shiny::NS(id)
  shiny::plotOutput(ns("main_plot"), height = "300px")
}
geyserUI <- function(id) {
  ns <- shiny::NS(id)
  shiny::uiOutput(ns("bw_adjust"))
}

