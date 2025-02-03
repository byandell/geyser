#' Shiny Server for Geyser Graphics Histogram
#'
#' @param id shiny identifier
#' @param df reactive data frame

#' @return reactive server
#' @export
#' @rdname histServer
#' @importFrom shiny checkboxInput moduleServer NS plotOutput renderPlot 
#'             renderUI selectInput shinyApp sliderInput uiOutput
#' @importFrom bslib page
#' @importFrom graphics hist lines rug
#' @importFrom stats density
#' @importFrom stringr str_to_title
histServer <- function(id, df = shiny::reactive(faithful)) {
  shiny::moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    # Output Main Plot
    output$main_plot <- shiny::renderPlot({
      shiny::req(df())
      if(ncol(df()) < 1) return(NULL)
      
      xvar <- colnames(df())[1]
      graphics::hist(df()[[xvar]],
                     probability = TRUE,
                     breaks = as.numeric(input$n_breaks),
                     xlab = xvar,
                     main = stringr::str_to_title(xvar))
      
      if (input$individual_obs) {
        graphics::rug(df()[[xvar]])
      }
      if (input$density) {
        shiny::req(df())
        shiny::req(input$bw_adjust)
        dens <- stats::density(df()[[xvar]],
                               adjust = input$bw_adjust)
        graphics::lines(dens, col = "blue")
      }
    })
    
    # Input Bandwidth Adjustment
    output$bw_adjust <- shiny::renderUI({
      if(input$density) {
        shiny::sliderInput(inputId = ns("bw_adjust"),
                           label = "Bandwidth adjustment:",
                           min = 0.2, max = 2, value = 1, step = 0.2)
      }
    })
  })
}
#' Shiny Module Input for Geyser Graphics Histogram
#' @param id identifier for shiny reactive
#' @return nothing returned
#' @rdname histServer
#' @export
histInput <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::selectInput(inputId = ns("n_breaks"),
                label = "Number of bins in histogram (approximate):",
                choices = c(10, 20, 35, 50),
                selected = 20),
    shiny::checkboxInput(inputId = ns("individual_obs"),
                  label = shiny::strong("Show individual observations"),
                  value = FALSE),
    
    shiny::checkboxInput(inputId = ns("density"),
                  label = shiny::strong("Show density estimate"),
                  value = FALSE))
}
#' Shiny Module UI for Geyser Graphics Histogram
#' @param id identifier for shiny reactive
#' @return nothing returned
#' @rdname histServer
#' @export
histUI <- function(id) {
  ns <- shiny::NS(id)
  shiny::uiOutput(ns("bw_adjust"))
}
#' Shiny Module Output for Geyser Graphics Histogram
#' @param id identifier for shiny reactive
#' @return nothing returned
#' @rdname histServer
#' @export
histOutput <- function(id) {
  ns <- shiny::NS(id)
  shiny::plotOutput(ns("main_plot"), height = "300px")
}
#' Shiny Module App for Geyser Graphics Histogram
#' @return nothing returned
#' @rdname histServer
#' @export
histApp <- function() {
  ui <- bslib::page(
    histInput("hist"), 
    histOutput("hist"),
    # Display this only if the density is shown
    histUI("hist")
  )
  server <- function(input, output, session) {
    histServer("hist") 
  }
  shiny::shinyApp(ui, server)
}
