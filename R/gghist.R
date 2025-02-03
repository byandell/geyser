#' Shiny Server for Geyser Ggplot2 Histogram
#'
#' @param id shiny identifier
#' @param df reactive data frame

#' @return reactive server
#' @export
#' @rdname gghistServer
#' @importFrom shiny checkboxInput moduleServer NS plotOutput renderPlot
#'             renderUI selectInput shinyApp sliderInput uiOutput
#' @importFrom bslib page
#' @importFrom ggplot2 aes after_stat geom_histogram geom_rug ggplot ggtitle
#'             stat_density xlab
#' @importFrom rlang .data
#' @importFrom stringr str_to_title
gghistServer <- function(id, df = shiny::reactive(faithful)) {
  shiny::moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    # Output Main Plot
    output$main_plot <- shiny::renderPlot({
      shiny::req(df())
      if(ncol(df()) < 1) return(ggplot2::ggplot())
      
      xvar <- colnames(df())[1]
      p <- ggplot2::ggplot(df()) +
        ggplot2::aes(.data[[xvar]]) +
        ggplot2::geom_histogram(
          ggplot2::aes(y = ggplot2::after_stat(density)),
          bins = as.numeric(input$n_breaks),
          color = "black", fill = "white") +
        ggplot2::xlab(xvar) +
        ggplot2::ggtitle(stringr::str_to_title(xvar))
      
      if (input$individual_obs) {
        p <- p + ggplot2::geom_rug()
      }
      if (input$density) {
        shiny::req(input$bw_adjust)
        p <- p + ggplot2::stat_density(
          adjust = input$bw_adjust,
          color = "blue", linewidth = 1, fill = "transparent")
      }
      print(p)
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
#' Shiny Module Input for Geyser Ggplot2 Histogram
#' @param id identifier for shiny reactive
#' @return nothing returned
#' @rdname gghistServer
#' @export
gghistInput <- function(id) {
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
#' Shiny Module UI for Geyser Ggplot2 Histogram
#' @param id identifier for shiny reactive
#' @return nothing returned
#' @rdname gghistServer
#' @export
gghistUI <- function(id) {
  ns <- shiny::NS(id)
  shiny::uiOutput(ns("bw_adjust"))
}
#' Shiny Module Output for Geyser Ggplot2 Histogram
#' @param id identifier for shiny reactive
#' @return nothing returned
#' @rdname gghistServer
#' @export
gghistOutput <- function(id) {
  ns <- shiny::NS(id)
  shiny::plotOutput(ns("main_plot"), height = "300px")
}
#' Shiny Module App for Geyser Ggplot2 Histogram
#' @return nothing returned
#' @rdname gghistServer
#' @export
gghistApp <- function() {
  ui <- bslib::page(
    gghistInput("gghist"), 
    gghistOutput("gghist"),
    # Display this only if the density is shown
    gghistUI("gghist")
  )
  server <- function(input, output, session) {
    gghistServer("gghist")
  }
  shiny::shinyApp(ui, server)
}
