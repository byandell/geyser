#' Shiny App for Geyser Data Switch
#'
#' @param id shiny identifier
#' @importFrom shiny moduleServer NS renderUI selectInput shinyApp uiOutput
#' @importFrom bslib layout_columns page
#' @export
switchApp <- function() {
  ui <- bslib::page(
    switchInput("switch"),
    switchOutput("switch"), 
    switchUI("switch")
  )
  server <- function(input, output, session) {
    switchServer("switch")
  }
  shiny::shinyApp(ui, server)
}
#' @rdname switchApp
#' @export
switchServer <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    # Module to select `dataset()`.
    dataset <- datasetsServer("datasets")
    # Modules to plot data.
    histServer("hist", dataset)
    gghistServer("gghist", dataset)
    ggpointServer("ggpoint", dataset)
    # Switches
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
#' @rdname switchApp
#' @export
switchInput <- function(id) {
  ns <- shiny::NS(id)
  list(
    bslib::layout_columns(
      shiny::selectInput(ns("plottype"), "Plot Type:",
                         c("hist","gghist","ggpoint")),
      datasetsInput(ns("datasets")),
      datasetsUI(ns("datasets"))),
  shiny::uiOutput(ns("inputSwitch"))
  )
}
#' @rdname switchApp
#' @export
switchUI <- function(id) {
  ns <- shiny::NS(id)
  shiny::uiOutput(ns("uiSwitch"))
}
#' @rdname switchApp
#' @export
switchOutput <- function(id) {
  ns <- shiny::NS(id)
  shiny::uiOutput(ns("outputSwitch"))
}
