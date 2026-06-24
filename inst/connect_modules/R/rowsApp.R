#' Shiny App for Geyser Rows
#'
#' @param id shiny identifier
#' @importFrom shiny moduleServer NS renderUI selectInput shinyApp uiOutput
#' @importFrom bslib card card_header layout_columns page
#' @export
rowsApp <- function() {
  ui <- bslib::page(
    title = "Geyser Rows Modules",
    rowsInput("rows"),
    rowsUI("rows")
  )
  server <- function(input, output, session) {
    rowsServer("rows")
  }
  shiny::shinyApp(ui, server)
}
#' @rdname rowsApp
#' @export
rowsServer <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    ns <- session$ns
    # Module to select `dataset()`.
    dataset <- datasetsServer("datasets")
    # Modules to plot data.
    histServer("hist", dataset)
    gghistServer("gghist", dataset)
    ggpointServer("ggpoint", dataset)
  })
}
#' @rdname rowsApp
#' @export
rowsInput <- function(id) {
  ns <- shiny::NS(id)
  bslib::layout_columns(
    datasetsInput(ns("datasets")),
    datasetsUI(ns("datasets"))
  )
}
#' @rdname rowsApp
#' @export
rowsUI <- function(id) {
  ns <- shiny::NS(id)
  bslib::layout_columns(
    bslib::card(bslib::card_header("hist"),
                histInput(ns("hist")), 
                histOutput(ns("hist")),
                histUI(ns("hist"))),
    bslib::card(bslib::card_header("gghist"),
                gghistInput(ns("gghist")), 
                gghistOutput(ns("gghist")),
                gghistUI(ns("gghist"))),
    bslib::card(bslib::card_header("ggpoint"),
                ggpointInput(ns("ggpoint")), 
                ggpointOutput(ns("ggpoint")),
                ggpointUI(ns("ggpoint"))))
}
