#' Shiny Server for Selected R Datasets
#'
#' @param id shiny identifier

#' @return reactive server
#' @export
#' @rdname datasetsServer
#' @importFrom shiny moduleServer NS reactive renderUI req selectInput shinyApp
#'             uiOutput
#' @importFrom bslib page
#' @importFrom dplyr select where
datasetsServer <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    # Select Dataset.
    # Static `datanames` = names in `datasets` package.
    data <- datanames()
    output$dataset <- shiny::renderUI({
      shiny::selectInput(ns("dataset"), "Dataset:", data$name)
    })
    dataset <- shiny::reactive({
      shiny::req(input$dataset, input$columns)
      data <- get(input$dataset)
      # Contingency of columns for previous dataset.
      if(!all(input$columns %in% colnames(data)))
        return(NULL)
      data[, input$columns, drop = FALSE]
    })
    
    # Columns
    output$columns <- shiny::renderUI({
      choices <- shiny::req(columnnames())
      if(shiny::isTruthy(input$columns))
        choices <- unique(c(input$columns, choices))
      shiny::selectInput(ns("columns"), "Variables:", choices = choices,
                         selected = input$columns,
                         multiple = TRUE)
    })
    columnnames <- shiny::reactive({
      shiny::req(input$dataset)
      names(get(input$dataset) |> as.data.frame() |>
        dplyr::select(dplyr::where(is.numeric)))
    })
    shiny::observeEvent(shiny::req(input$dataset), {
      # Get `dataset()`, selecting only numeric columns.
      choices <- columnnames()
      shiny::updateSelectInput(session, "columns", choices = choices,
                               selected = NULL)
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
#' @rdname datasetsServer
#' @export
datasetsInput <- function(id) {
  ns <- shiny::NS(id)
  shiny::uiOutput(ns("dataset"))
}
#' Shiny Module Input
#' @return nothing returned
#' @rdname datasetsServer
#' @export
datasetsUI <- function(id) {
  ns <- shiny::NS(id)
  shiny::uiOutput(ns("columns"))
}
#' Shiny Module Output
#' @return nothing returned
#' @rdname datasetsServer
#' @export
datasetsOutput <- function(id) {
  ns <- shiny::NS(id)
  DT::dataTableOutput(ns("table"))
}
#' Shiny Module App
#' @return nothing returned
#' @rdname datasetsServer
#' @export
datasetsApp <- function() {
  ui <- bslib::page(
    datasetsInput("datasets"), 
    datasetsUI("datasets"), 
    datasetsOutput("datasets")
  )
  server <- function(input, output, session) {
    datasetsServer("datasets")
  }
  shiny::shinyApp(ui, server)
}
