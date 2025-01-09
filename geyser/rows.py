from shiny import App, module, reactive, render, ui
import geyser.io as io
from geyser.hist import *
from geyser.gghist import *
from geyser.ggpoint import *
from geyser.datasets import *

@module.server
def rows_server(input, output, session):
    """Rows Server."""
    dataset = datasets_server("datasets")
    hist_server("hist", dataset)
    gghist_server("gghist", dataset)
    ggpoint_server("ggpoint", dataset)

# rows_server("rows")

@module.ui
def rows_input():
    """rows Input."""
    return ui.row(
        ui.column(6, datasets_input("datasets")),
        ui.column(6, datasets_ui("datasets"))
    )

# rows_input("rows")

@module.ui
def rows_ui():
    """Rows UI."""
    return ui.row(
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
    )

# rows_ui("rows")

def rows_app():
    """Rows App."""
    app_ui = ui.page_fluid(
        rows_input("rows"),
        rows_ui("rows")
    )
    def app_server(input, output, session):
        rows_server("rows")

    app = App(app_ui, app_server)

    #if __name__ == '__main__':
    io.app_run(app)

# hist_app()
