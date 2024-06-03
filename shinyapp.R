geyserUI <- function() {
  shiny::bootstrapPage(
 
    geyserServerInput("geyser"), 

    geyserServerOutput("geyser"),
  
    # Display this only if the density is shown
    geyserServerCondInput("geyser")
  
  )
}

geyserServer <- function(input, output, session) {
  ns <- session$ns
  
  output$bw_adjust <- shiny::renderUI({
    if(input$density) {
      shiny::sliderInput(inputId = ns("bw_adjust"),
                  label = "Bandwidth adjustment:",
                  min = 0.2, max = 2, value = 1, step = 0.2)
    }
                   
  })
  
  output$main_plot <- shiny::renderPlot({
    hist(faithful$eruptions,
         probability = TRUE,
         breaks = as.numeric(input$n_breaks),
         xlab = "Duration (minutes)",
         main = "Geyser eruption duration")
    
    if (input$individual_obs) {
      rug(faithful$eruptions)
   }
    
    if (input$density) {
      req(input$bw_adjust)
      dens <- density(faithful$eruptions,
                      adjust = input$bw_adjust)
      lines(dens, col = "blue")
    }
    
  })
}
geyserServerInput <- function(id) {
  ns <- shiny::NS(id)
  tagList(
    shiny::selectInput(inputId = ns("n_breaks"),
                label = "Number of bins in histogram (approximate):",
                choices = c(10, 20, 35, 50),
                selected = 20),
    shiny::checkboxInput(inputId = ns("individual_obs"),
                  label = strong("Show individual observations"),
                  value = FALSE),
    
    shiny::checkboxInput(inputId = ns("density"),
                  label = strong("Show density estimate"),
                  value = FALSE))
}

geyserServerCondInput <- function(id) {
  ns <- shiny::NS(id)
  shiny::uiOutput(ns("bw_adjust"))
}
geyserServerOutput <- function(id) {
  ns <- shiny::NS(id)
  shiny::plotOutput(ns("main_plot"), height = "300px")
}

