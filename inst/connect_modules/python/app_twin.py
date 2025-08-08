# app_path <- "inst/connect_modules/app_twin.py"
# reticulate::py_run_file(app_path)

# context: setup
from shiny import App, module, reactive, render, ui
import geyser.io as io
from geyser.hist import *

# context: ui
app_ui = ui.page_fluid(
  ui.row(
    ui.column(6, ui.card(
      ui.panel_title("hist1"),
      hist_input("hist1"), 
      hist_output("hist1"),
      hist_ui("hist1")
    )),
    ui.column(6, ui.card(
      ui.panel_title("hist2"),
      hist_input("hist2"), 
      hist_output("hist2"),
      hist_ui("hist2")
    )),
    ),
  title = "Geyser Python Rows Modules"
)

# context: server
def app_server(input, output, session):
    hist_server("hist1")
    hist_server("hist2")

app = App(app_ui, app_server)

io.app_run(app)
