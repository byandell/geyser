# app_path <- "inst/build_module/5_python/appGghist.py"
# reticulate::py_run_file(app_path)

from shiny import App, render, ui
import geyser.io as io
from geyser.gghist import gghist_server, gghist_input, gghist_output, gghist_ui

app_ui = ui.page_fluid(
    gghist_input("gghist"),
    gghist_output("gghist"),
    gghist_ui("gghist")
)

def server(input, output, session):
    gghist_server("gghist")

app = App(app_ui, server)

# Can run with other name via `python inst/build_module/5_python/appHist.py`
# But need to find an unused port.
if __name__ == "__main__":
  io.app_run(app)
