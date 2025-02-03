#' Shiny Server for Geyser Data Wrapper
#'
#' @param id shiny identifier

#' @return reactive server
#' @export
#' @rdname wrapperServer
#' @importFrom shiny moduleServer NS renderUI selectInput shinyApp uiOutput
#' @importFrom bslib page
wrapperServer <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    # Module to select `dataset()`.
    dataset <- dataServer("data")
    # Modules to plot data.
    histServer("hist", dataset)
    gghistServer("gghist", dataset)
    ggpointServer("ggpoint", dataset)
    # Switches.
    output$inputSwitch <- shiny::renderUI({
      shiny::req(input$plottype)
      get(paste0(input$plottype, "Input"))(ns(input$plottype))
    })
    output$uiSwitch <- shiny::renderUI({
      shiny::req(input$plottype)
      get(paste0(input$plottype, "UI"))(ns(input$plottype))
    })
    output$outputSwitch <- shiny::renderUI({
      shiny::req(input$plottype)
      get(paste0(input$plottype, "Output"))(ns(input$plottype))
    })
  })
}
#' Shiny Module Input
#' @return nothing returned
#' @rdname wrapperServer
#' @export
wrapperInput <- function(id) {
  ns <- shiny::NS(id)
  list(
    shiny::selectInput(ns("plottype"), "Plot Type:",
                       c("hist","gghist","ggpoint")),
    dataInput(ns("data")),
    shiny::uiOutput(ns("inputSwitch"))
  )
}
#' Shiny Module UI
#' @return nothing returned
#' @rdname wrapperServer
#' @export
wrapperUI <- function(id) {
  ns <- shiny::NS(id)
  shiny::uiOutput(ns("uiSwitch"))
}
#' Shiny Module Output
#' @return nothing returned
#' @rdname wrapperServer
#' @export
wrapperOutput <- function(id) {
  ns <- shiny::NS(id)
  shiny::uiOutput(ns("outputSwitch"))
}
#' Shiny Module App
#' @return nothing returned
#' @rdname wrapperServer
#' @export
wrapperApp <- function() {
  ui <- bslib::page(
    wrapperInput("wrapper"), 
    wrapperUI("wrapper"),
    wrapperOutput("wrapper")
  )
  server <- function(input, output, session) {
    wrapperServer("wrapper")
  }
  shiny::shinyApp(ui, server)
}
