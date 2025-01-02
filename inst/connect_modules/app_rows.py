# app_path <- "inst/connect_modules/app_rows.py"
# reticulate::py_run_file(app_path)

# context: setup
from shiny import App, module, reactive, render, ui
import geyser.io as io
from geyser.hist import *
from geyser.gghist import *
from geyser.ggpoint import *
import nest_asyncio

nest_asyncio.apply()

# context: ui
app_ui = ui.page_fluid(
  ui.row(
    ui.column(6, datasets_input("datasets")),
    ui.column(6, datasets_ui("datasets"))
  ),
  ui.row(
    ui.column(4, ui.card(
      ui.panel_title("hist"),
      hist_input("hist"), 
      hist_output("hist"),
      hist_ui("hist")
    )),
    ui.column(4, ui.card(
      ui.panel_title("gghist"),
      gghist_input("gghist"), 
      gghist_output("gghist"),
      gghist_ui("gghist")
    )),
    ui.column(4, ui.card(
      ui.panel_title("ggpoint"),
      ggpoint_input("ggpoint"), 
      ggpoint_output("ggpoint"),
      ggpoint_ui("ggpoint")
    ))
  ),
  title = "Geyser Python Rows Modules"
)

# context: server
def app_server(input, output, session):
    dataset = datasets_server("datasets")
    hist_server("hist", dataset)
    gghist_server("gghist", dataset)
    ggpoint_server("ggpoint", dataset)

app = App(app_ui, app_server)

io.app_run(app)
