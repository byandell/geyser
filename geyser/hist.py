from shiny import App, module, reactive, render, ui
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from scipy.stats import gaussian_kde
import geyser.io as io

# Create default reactive for dataset.
@reactive.calc
def default_dataset():
    import seaborn as sns
    return sns.load_dataset("geyser")

@module.server
def hist_server(input, output, session, data_set=default_dataset):
    """Hist Server."""

    if data_set is None:
        return None

    @reactive.calc
    def xval():
        return data_set().columns[0]
    @reactive.calc
    def datacol():
        return data_set()[xval()]
    
    @render.plot
    def main_plot():
        if not isinstance(data_set(), pd.DataFrame):
            return None
        if data_set().shape[1] < 1:
            return None
        fig, ax = plt.subplots()
        n_breaks = int(input.n_breaks())
        hist_data = np.histogram(datacol(), bins=n_breaks, density=True)
        ax.bar(hist_data[1][:-1], hist_data[0], width=np.diff(hist_data[1]), edgecolor='black', align='edge')

        if input.individual_obs():
            ax.plot(datacol(), np.zeros_like(datacol()), 'r|', markersize=10)

        if input.density():
            bw_adjust = input.bw_adjust()
            kde = gaussian_kde(datacol(), bw_method=bw_adjust)
            x_grid = np.linspace(min(datacol()), max(datacol()), 1000)
            ax.plot(x_grid, kde(x_grid), color='blue')

        ax.set_xlabel(xval())
        ax.set_title(xval())
        
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
    
# hist_server("hist")

@module.ui
def hist_input():
    """Hist Input."""
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

# hist_input("hist")

@module.ui
def hist_output():
    """Hist Output."""
    return ui.output_plot("main_plot")

# hist_output("hist")

@module.ui
def hist_ui():
    """Hist UI."""
    return ui.output_ui("output_bw_adjust")

# hist_ui("hist")

def hist_app():
    """Hist App."""
    app_ui = ui.page_fluid(
        hist_input("hist"),
        hist_output("hist"),
        hist_ui("hist")
    )
    def app_server(input, output, session):
        hist_server("hist")

    app = App(app_ui, app_server)

    #if __name__ == '__main__':
    io.app_run(app)

# hist_app()
