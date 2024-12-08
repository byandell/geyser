#' Shiny Server for Geyser Rows
#'
#' @param id shiny identifier

#' @return reactive server
#' @export
#' @rdname rowsServer
#' @importFrom shiny bootstrapPage column fluidRow moduleServer NS 
#'             renderUI selectInput shinyApp uiOutput
rowsServer <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    # Module to select `dataset()`.
    # This `datasets.R` module is fancier than `data.R`.
    dataset <- datasetsServer("datasets")
    
    # Modules to plot data.
    histServer("hist", dataset)
    gghistServer("gghist", dataset)
    ggpointServer("ggpoint", dataset)
  })
}
#' Shiny Module Input
#' @return nothing returned
#' @rdname rowsServer
#' @export
rowsInput <- function(id) {
  ns <- shiny::NS(id)
  shiny::fluidRow(
    shiny::column(6, datasetsInput(ns("datasets"))),
    shiny::column(6, datasetsUI(ns("datasets")))
  )
}
  #' Shiny Module UI
#' @return nothing returned
#' @rdname rowsServer
#' @export
rowsUI <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::fluidRow(
      shiny::column(4, shiny::tagList(
        shiny::titlePanel(ns("hist")),
        histInput(ns("hist")), 
        histOutput(ns("hist")),
        histUI(ns("hist"))
      )),
      shiny::column(4, shiny::tagList(
        shiny::titlePanel(ns("gghist")),
        gghistInput(ns("gghist")), 
        gghistOutput(ns("gghist")),
        gghistUI(ns("gghist"))
      )),
      shiny::column(4, shiny::tagList(
        shiny::titlePanel(ns("ggpoint")),
        ggpointInput(ns("ggpoint")), 
        ggpointOutput(ns("ggpoint")),
        ggpointUI(ns("ggpoint"))
      ))
    )
  )
}
#' Shiny Module App
#' @return nothing returned
#' @rdname rowsServer
#' @export
rowsApp <- function() {
  ui <- shiny::fluidPage(
    shiny::titlePanel("Geyser Rows Modules in Shiny, Brian Yandell"),
    rowsInput("rows")
    rowsUI("rows")
  )
  server <- function(input, output, session) {
    rowsServer("rows")
  }
  shiny::shinyApp(ui, server)
}
