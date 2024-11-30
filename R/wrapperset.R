#' Shiny Server for Geyser Wrapper
#'
#' @param id shiny identifier

#' @return reactive server
#' @export
#' @rdname wrappersetServer
#' @importFrom shiny bootstrapPage column fluidRow moduleServer NS 
#'             renderUI selectInput shinyApp uiOutput
wrappersetServer <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    # Module to select `dataset()`.
    # This `datasets.R` module is fancier than `data.R`.
    dataset <- datasetsServer("datasets")
    
    # Modules to plot data.
    histServer("hist", dataset)
    gghistServer("gghist", dataset)
    ggpointServer("ggpoint", dataset)
    
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
#' @rdname wrappersetServer
#' @export
wrappersetInput <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::fluidRow(
      shiny::column(4,
        shiny::selectInput(ns("plottype"), "Plot Type:",
                           c("hist","gghist","ggpoint"))),
      shiny::column(4, datasetsInput(ns("datasets"))),
      shiny::column(4, datasetsUI(ns("datasets")))
    ),
    shiny::uiOutput(ns("inputSwitch"))
  )
}
#' Shiny Module UI
#' @return nothing returned
#' @rdname wrappersetServer
#' @export
wrappersetUI <- function(id) {
  ns <- shiny::NS(id)
  shiny::uiOutput(ns("uiSwitch"))
}
#' Shiny Module Output
#' @return nothing returned
#' @rdname wrappersetServer
#' @export
wrappersetOutput <- function(id) {
  ns <- shiny::NS(id)
  shiny::uiOutput(ns("outputSwitch"))
}
#' Shiny Module App
#' @return nothing returned
#' @rdname wrappersetServer
#' @export
wrappersetApp <- function() {
  ui <- shiny::bootstrapPage(
    wrappersetInput("wrapperset"), 
    wrappersetUI("wrapperset"),
    wrappersetOutput("wrapperset")
  )
  server <- function(input, output, session) {
    wrappersetServer("wrapperset")
  }
  shiny::shinyApp(ui, server)
}
