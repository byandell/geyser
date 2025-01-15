# app_path <- "inst/connect_modules/app_pages.py"
# reticulate::py_run_file(app_path)

# context: setup
from shiny import App, module, reactive, render, ui
import geyser.io as io
from geyser.hist import *
from geyser.gghist import *
from geyser.ggpoint import *

# context: ui
app_ui = ui.page_navbar(
  ui.nav_panel("hist",
               hist_input("hist"), 
               hist_output("hist"),
               hist_ui("hist")
  ),
  ui.nav_panel("gghist",
               gghist_input("gghist"), 
               gghist_output("gghist"),
               gghist_ui("gghist")
  ),
  ui.nav_panel("ggpoint",
               ggpoint_input("ggpoint"), 
               ggpoint_output("ggpoint"),
               ggpoint_ui("ggpoint")
  ),
  title = "Geyser Python Modules with NavBar"
)

# context: server
def app_server(input, output, session):
    hist_server("hist")
    gghist_server("gghist")
    ggpoint_server("ggpoint")

app = App(app_ui, app_server)

io.app_run(app)
