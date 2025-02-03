# New Faithful "fake" Functions
# geyser/newFaithful/newFaithful.R

# Reorders code to put `server` logic at top of file.
# Uses server logic for `density` as in `oldFaithful/appLogic.R`.
# Has no namespace for `inputId` elements.

fakeServer <- function(input, output, session) {
  output$main_plot <- renderPlot({
    hist(faithful$eruptions, probability = TRUE,
         breaks = as.numeric(input$n_breaks),
         xlab = "Duration (minutes)", main = "Geyser eruption duration")
    if (input$individual_obs) {
      rug(faithful$eruptions)
    }
    if (input$density) {
      req(input$bw_adjust)
      dens <- density(faithful$eruptions, adjust = input$bw_adjust)
      lines(dens, col = "blue")
    }
  })
  
  output$bw_adjust <- shiny::renderUI({
    if(input$density) {
      shiny::sliderInput(inputId = "bw_adjust",
                         label = "Bandwidth adjustment:",
                         min = 0.2, max = 2, value = 1, step = 0.2)
    }
  })
}

fakeUI <- function() {
  bslib::page(
    # Input
    selectInput(inputId = "n_breaks",
                label = "Number of bins in histogram (approximate):",
                choices = c(10, 20, 35, 50),
                selected = 20),
    checkboxInput(inputId = "individual_obs",
                  label = strong("Show individual observations"),
                  value = FALSE),
    checkboxInput(inputId = "density",
                  label = strong("Show density estimate"),
                  value = FALSE),
    # Output
    plotOutput(outputId = "main_plot", height = "300px"),
    
    # UI
    # Display this only if the density is shown
    shiny::uiOutput("bw_adjust")
  )
}
