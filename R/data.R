#' Shiny Server for Geyser Graphics Histogram
#'
#' @param id shiny identifier

#' @return reactive server
#' @export
#' @rdname dataServer
#' @importFrom shiny moduleServer NS selectInput shinyApp
#' @importFrom bslib page
#' @importFrom DT dataTableOutput renderDataTable
dataServer <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    dataset <- shiny::reactive({
      switch(shiny::req(input$dataset),
        faithful = faithful,
        mtcars   = mtcars[, c("mpg","wt")])
    })
    
    output$table <-   DT::renderDataTable(
      shiny::req(dataset())
    )
    #########################################
    dataset
  })
}
#' Shiny Module Input
#' @return nothing returned
#' @rdname dataServer
#' @export
dataInput <- function(id) {
  ns <- shiny::NS(id)
  shiny::selectInput(ns("dataset"), "Dataset:", c("faithful","mtcars"))
}
#' Shiny Module Output
#' @return nothing returned
#' @rdname dataServer
#' @export
dataOutput <- function(id) {
  ns <- shiny::NS(id)
  DT::dataTableOutput(ns("table"))
}
#' Shiny Module App
#' @return nothing returned
#' @rdname dataServer
#' @export
dataApp <- function() {
  ui <- bslib::page(
    dataInput("data"), 
    dataOutput("data")
  )
  server <- function(input, output, session) {
    dataServer("data")
  }
  shiny::shinyApp(ui, server)
}
