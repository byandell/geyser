# https://shiny.posit.co/r/gallery/start-simple/faithful/
# geyser/oldFaithful/appLogic.R

# Replace `conditionalPanel` in `ui` with `server` logic.
# 1. Remove `conditionalPanel` from `ui`.
# 2. Use `uiOutput` in `ui` and `renderUI` in `server`,
# 3. Ask if `input$density` is `TRUE` with `if` at 2 places in `server`.
# 4. Check if `input$bw_adjust` has been set with `req` before using.

ui <- bootstrapPage(
  selectInput(inputId = "n_breaks",
              label = "Number of bins in histogram (approximate):",
              choices = c(10, 20, 35, 50), selected = 20),
  checkboxInput(inputId = "individual_obs",
                label = strong("Show individual observations"),
                value = FALSE),
  checkboxInput(inputId = "density", label = strong("Show density estimate"),
                value = FALSE),
  plotOutput(outputId = "main_plot", height = "300px"),
  
  # Display this only if the density is shown
  uiOutput("bw_adjust")
#  conditionalPanel(condition = "input.density == true",
#    sliderInput(inputId = "bw_adjust", label = "Bandwidth adjustment:",
#      min = 0.2, max = 2, value = 1, step = 0.2))
)

server <- function(input, output) {
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
      sliderInput(inputId = "bw_adjust", label = "Bandwidth adjustment:",
                  min = 0.2, max = 2, value = 1, step = 0.2)
    }
  })
}

shiny::shinyApp(ui, server)