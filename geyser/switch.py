from shiny import App, module, reactive, render, ui
import geyser.io as io
from geyser.hist import *
from geyser.gghist import *
from geyser.ggpoint import *
from geyser.datasets import *

module_dict = {
    "hist_input":     hist_input,
    "hist_output":    hist_output,
    "hist_ui":        hist_ui,
    "gghist_input":   gghist_input,
    "gghist_output":  gghist_output,
    "gghist_ui":      gghist_ui,
    "ggpoint_input":  ggpoint_input,
    "ggpoint_output": ggpoint_output,
    "ggpoint_ui":     ggpoint_ui
}

@module.server
def switch_server(input, output, session):
    """switch Server."""
    dataset = datasets_server("datasets")
    hist_server("hist", dataset)
    gghist_server("gghist", dataset)
    ggpoint_server("ggpoint", dataset)
    
    # Alternative: use match expr: case expr:.
    @render.ui
    def input_switch():
      return module_dict[f"{input.plottype()}_input"](input.plottype())
    @render.ui
    def output_switch():
      return module_dict[f"{input.plottype()}_output"](input.plottype())
    @render.ui
    def ui_switch():
      return module_dict[f"{input.plottype()}_ui"](input.plottype())

# switch_server("switch")

@module.ui
def switch_input():
    """switch Input."""
    return ui.card(
      ui.row(
        ui.column(4, ui.input_select("plottype", "Plot Type:",
            ["hist","gghist","ggpoint"])),
        ui.column(4, datasets_input("datasets")),
        ui.column(4, datasets_ui("datasets"))
      ),
      ui.output_ui("input_switch")
    )

# switch_input("switch")

@module.ui
def switch_output():
    """Switch Output."""
    return ui.output_ui("output_switch")
@module.ui
def switch_ui():
    """switch UI."""
    return ui.output_ui("ui_switch")

# switch_ui("switch")

def switch_app():
    """switch App."""
    app_ui = ui.page_fluid(
        switch_input("switch"),
        switch_output("switch"),
        switch_ui("switch")
    )
    def app_server(input, output, session):
        switch_server("switch")

    app = App(app_ui, app_server)

    #if __name__ == '__main__':
    io.app_run(app)

# hist_app()
