from shiny import App, module, reactive, render, ui
import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import gaussian_kde
from geyser import io
    
@module.server
def geyserServer(input, output, session):
    """Geyser Server."""
        
    # `faithful$eruptions` from R
    import seaborn as sns
    faithful_df = sns.load_dataset("geyser")
    eruptions = faithful_df[faithful_df.columns[0]]

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
    
# geyserServer("geyser")

@module.ui
def geyserInput():
    """Geyser Input."""
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

# geyserInput("geyser")

@module.ui
def geyserOutput():
    """Geyser Output."""
    return ui.output_plot("main_plot")

# geyserOutput("geyser")

@module.ui
def geyserUI():
    """Geyser UI."""
    return ui.output_ui("output_bw_adjust")

# geyserUI("geyser")

def geyserApp():
    """Geyser App."""
    app_ui = ui.page_fluid(
        geyserInput("geyser"),
        geyserOutput("geyser"),
        geyserUI("geyser")
    )
    def app_server(input, output, session):
        geyserServer("geyser")

    app = App(app_ui, app_server)

    app.run()

# geyserApp()
