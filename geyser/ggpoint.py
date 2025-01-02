from shiny import App, module, reactive, render, ui
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from plotnine import ggplot, aes, after_stat, geom_point, geom_rug
from plotnine import geom_smooth, xlab, ylab, ggtitle
from scipy.stats import gaussian_kde
import geyser.io as io

# Create default reactive for dataset.
@reactive.calc
def default_dataset():
    return io.r_object('faithful')

@module.server
def ggpoint_server(input, output, session, data_set=default_dataset):
    """GGPoint Server."""

    if data_set is None:
        return None
    
    @reactive.calc
    def xval():
        return data_set().columns[0]
    def yval():
        return data_set().columns[1]

    @render.plot
    def main_plot():
        if not isinstance(data_set(), pd.DataFrame):
            return None
        if data_set().shape[1] < 2:
            return None
        p = (ggplot(data_set()) +
            aes(x = xval(), y = yval()) +
            geom_point(color = "black", fill = "white"))

        if input.individual_obs():
            p = p + geom_rug()

        if input.density():
            bw_adjust = input.bw_adjust()
            p = p + geom_smooth(color = "blue", span = bw_adjust)

        p = (p +
            xlab(xval()) + ylab(yval()) +
            ggtitle(xval()))
        
        return p
        
    @render.ui
    def output_bw_adjust():
        if input.density():
            return ui.input_slider(
                "bw_adjust",
                "Bandwidth adjustment:",
                min=0,
                max=1.0,
                value=0.5,
                step=0.05
            )
    
# ggpoint_server("ggpoint")

@module.ui
def ggpoint_input():
    """ggpoint Input."""
    return ui.card(
        ui.input_checkbox(
            "individual_obs",
            "Show individual observations",
            value=False
        ),
        ui.input_checkbox(
            "density",
            "Show density estimate",
            value=False
        )
    )

# ggpoint_input("ggpoint")

@module.ui
def ggpoint_output():
    """ggpoint Output."""
    return ui.output_plot("main_plot")

# ggpoint_output("ggpoint")


@module.ui
def ggpoint_ui():
    """ggpoint UI."""
    return ui.output_ui("output_bw_adjust")

# ggpoint_ui("ggpoint")

def ggpoint_app():
    """ggpoint App."""
    app_ui = ui.page_fluid(
        ggpoint_input("ggpoint"),
        ggpoint_output("ggpoint"),
        ggpoint_ui("ggpoint")
    )
    def app_server(input, output, session):
        ggpoint_server("ggpoint")

    app = App(app_ui, app_server)

    #if __name__ == '__main__':
    io.app_run(app)

# ggpoint_app()
