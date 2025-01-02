from shiny import App, module, reactive, render, ui
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from plotnine import ggplot, aes, after_stat, geom_histogram, geom_rug
from plotnine import stat_density, xlab, ggtitle
from scipy.stats import gaussian_kde
import geyser.io as io

# Create default reactive for dataset.
@reactive.calc
def default_dataset():
    return io.r_object('faithful')

@module.server
def gghist_server(input, output, session, data_set=default_dataset):
    """GGHist Server."""

    if data_set is None:
        return None

    @reactive.calc
    def xval():
        return data_set().columns[0]

    @render.plot
    def main_plot():
        if not isinstance(data_set(), pd.DataFrame):
            return None
        n_breaks = int(input.n_breaks())
        p = (ggplot(data_set()) +
            aes(x = xval()) +
            geom_histogram(aes(y=after_stat("density")), # density
              bins = n_breaks))

        if input.individual_obs():
            p = p + geom_rug()

        if input.density():
            bw_adjust = input.bw_adjust()
            p = p + stat_density(adjust = bw_adjust, color = "blue")

        p = (p +
            xlab(xval()) +
            ggtitle(xval()))
        
        return p
        
    @render.ui
    def output_bw_adjust():
        if input.density():
            return ui.input_slider(
                "bw_adjust",
                "Bandwidth adjustment:",
                min=0.2,
                max=2.0,
                value=1.0,
                step=0.2
            )
    
# gghist_server("gghist")

@module.ui
def gghist_input():
    """GGHist Input."""
    return ui.card(
        ui.input_select(
            "n_breaks",
            "Number of bins in histogram (approximate):",
            choices=[10, 20, 35, 50],
            selected=20
        ),
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

# gghist_input("gghist")

@module.ui
def gghist_output():
    """GGHist Output."""
    return ui.output_plot("main_plot")

# gghist_output("gghist")


@module.ui
def gghist_ui():
    """GGHist UI."""
    return ui.output_ui("output_bw_adjust")

# gghist_ui("gghist")

def gghist_app():
    """GGHist App."""
    app_ui = ui.page_fluid(
        gghist_input("gghist"),
        gghist_output("gghist"),
        gghist_ui("gghist")
    )
    def app_server(input, output, session):
        gghist_server("gghist")

    app = App(app_ui, app_server)

    #if __name__ == '__main__':
    io.app_run(app)

# gghist_app()
