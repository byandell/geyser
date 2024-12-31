# app_path <- "inst/build_module/5_python/appGghist.py"
# reticulate::py_run_file(app_path)

from shiny import App, render, ui
from geyser import app_run

# run_hist.py
with open('/Users/brianyandell/Documents/Research/geyser/python/gghist.py', 'r') as file:
    code = file.read()
exec(code)

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
  app_run(app)
