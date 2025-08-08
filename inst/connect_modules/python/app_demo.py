# app_path <- "inst/connect_modules/app_demo.py"
# reticulate::py_run_file(app_path)

# context: setup
#pip install pip@git+https://github.com/byandell/geyser
from shiny import App, module, reactive, render, ui
import geyser.io as io
from geyser.hist import *
from geyser.gghist import *
from geyser.ggpoint import *
from geyser.rows import *
from geyser.switch import *

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
  ui.nav_panel("rows",
               rows_input("rows"), 
               rows_ui("rows")
  ),
  ui.nav_panel("switch",
               switch_input("switch"), 
               switch_output("switch"),
               switch_ui("switch")
  ),
  title = "Geyser Python Demo"
)


# context: server
def app_server(input, output, session):
    hist_server("hist")
    gghist_server("gghist")
    ggpoint_server("ggpoint")
    rows_server("rows")
    switch_server("switch")

app = App(app_ui, app_server)

io.app_run(app)
