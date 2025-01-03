# app_path <- "inst/connect_modules/app_dupe.py"
# reticulate::py_run_file(app_path)

# context: setup
from shiny import App, module, reactive, render, ui
import geyser.io as io
from geyser.hist import *
import nest_asyncio

nest_asyncio.apply()

# context: ui
app_ui = ui.page_fluid(
  ui.row(
    ui.column(6, ui.card(
      ui.panel_title("hist"),
      hist_input("hist"), 
      hist_output("hist"),
      hist_ui("hist")
    )),
    ui.column(6, ui.card(
      ui.panel_title("hist"),
      hist_input("hist"), 
      hist_output("hist"),
      hist_ui("hist")
    )),
    ),
  title = "Geyser Python Rows Modules"
)

# context: server
def app_server(input, output, session):
    hist_server("hist")
    hist_server("hist")

app = App(app_ui, app_server)

io.app_run(app)
