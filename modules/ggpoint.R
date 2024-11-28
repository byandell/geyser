#' Shiny Server for Geyser Ggplot2 Point Plot
#'
#' @param id shiny identifier
#' @param df data frame
#' @param xvar,yvar x and y columns of data frame `df`

#' @return reactive server
#' @export
#' @rdname ggpointServer
#' @importFrom shiny bootstrapPage checkboxInput moduleServer NS plotOutput
#'             renderPlot renderUI selectInput shinyApp sliderInput uiOutput
#' @importFrom ggplot2 aes geom_point geom_rug geom_smooth ggplot ggitlel
#'             xlab ylab
#' @importFrom rlang .data
ggpointServer <- function(id, df, xvar, yvar) {
  shiny::moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    # Output Main Plot
    output$main_plot <- shiny::renderPlot({
      p <- ggplot2::ggplot(df) +
        ggplot2::aes(.data[[xvar]], .data[[yvar]]) +
        ggplot2::geom_point(
          color = "black", fill = "white") +
        ggplot2::xlab("Duration (minutes)") +
        ggplot2::ylab("Wait time (minutes)") +
        ggplot2::ggtitle("Geyser eruption duration and wait time")
      
      if (input$individual_obs) {
        p <- p + ggplot2::geom_rug()
      }
      if (input$smooth) {
        shiny::req(input$bw_adjust)
        p <- p +
          ggplot2::geom_smooth(formula = "y~x", se = FALSE,
            method = "loess", span = input$bw_adjust,
            color = "blue", linewidth = 1)
      }
      print(p)
    })
    
    # Input Bandwidth Adjustment
    output$bw_adjust <- shiny::renderUI({
      if(input$smooth) {
        shiny::sliderInput(inputId = ns("bw_adjust"),
                           label = "Span adjustment:",
                           min = 0, max = 2, value = 0.75, step = 0.05)
      }
    })
  })
}
#' Shiny Module Input for Geyser Ggplot2 Histogram
#' @param id identifier for shiny reactive
#' @return nothing returned
#' @rdname ggpointServer
#' @export
ggpointInput <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::checkboxInput(inputId = ns("individual_obs"),
                  label = shiny::strong("Show individual observations"),
                  value = FALSE),
    
    shiny::checkboxInput(inputId = ns("smooth"),
                  label = shiny::strong("Show smooth estimate"),
                  value = FALSE))
}
#' Shiny Module UI for Geyser Ggplot2 Histogram
#' @param id identifier for shiny reactive
#' @return nothing returned
#' @rdname ggpointServer
#' @export
ggpointUI <- function(id) {
  ns <- shiny::NS(id)
  shiny::uiOutput(ns("bw_adjust"))
}
#' Shiny Module Output for Geyser Ggplot2 Histogram
#' @param id identifier for shiny reactive
#' @return nothing returned
#' @rdname ggpointServer
#' @export
ggpointOutput <- function(id) {
  ns <- shiny::NS(id)
  shiny::plotOutput(ns("main_plot"), height = "300px")
}
#' Shiny Module App for Geyser Ggplot2 Histogram
#' @return nothing returned
#' @rdname ggpointServer
#' @export
ggpointApp <- function() {
  ui <- shiny::bootstrapPage(
    ggpointInput("ggpoint"), 
    ggpointOutput("ggpoint"),
    # Display this only if the smooth is shown
    ggpointUI("ggpoint")
  )
  server <- function(input, output, session) {
    ggpointServer("ggpoint", faithful, "eruptions", "waiting")
  }
  shiny::shinyApp(ui, server)
}
