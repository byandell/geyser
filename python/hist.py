from shiny import App, module, reactive, render, ui
import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import gaussian_kde
    
@module.server
def hist_server(input, output, session):
    """Hist Server."""
    from rpy2 import robjects

    # `faithful$eruptions` from R
    eruptions = robjects.r['faithful'][0]
    
    @render.plot
    def main_plot():
        fig, ax = plt.subplots()
        n_breaks = int(input.n_breaks())
        hist_data = np.histogram(eruptions, bins=n_breaks, density=True)
        ax.bar(hist_data[1][:-1], hist_data[0], width=np.diff(hist_data[1]), edgecolor='black', align='edge')

        if input.individual_obs():
            ax.plot(eruptions, np.zeros_like(eruptions), 'r|', markersize=10)

        if input.density():
            bw_adjust = input.bw_adjust()
            kde = gaussian_kde(eruptions, bw_method=bw_adjust)
            x_grid = np.linspace(min(eruptions), max(eruptions), 1000)
            ax.plot(x_grid, kde(x_grid), color='blue')

        ax.set_xlabel("Duration (minutes)")
        ax.set_title("Geyser eruption duration")
        
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
    app.run()

# hist_app()
