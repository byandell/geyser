# app_path <- "inst/build_module/5_python/app_gghist.py"
# reticulate::py_run_file(app_path)

from shiny import App, module, reactive, render, ui
import numpy as np
import matplotlib.pyplot as plt
from plotnine import ggplot, aes, after_stat, geom_histogram, geom_rug
from plotnine import stat_density, xlab, ggtitle
from scipy.stats import gaussian_kde
from geyser import retrieveR, app_run

faithful_df = retrieveR('faithful')

app_ui = ui.page_fluid(
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
    ),
    ui.output_plot("main_plot"),
    ui.output_ui("output_bw_adjust")
)

def server(input, output, session):

    @render.plot
    def main_plot():
        n_breaks = int(input.n_breaks())
        p = (ggplot(faithful_df) +
            aes(x = eruptions) +
            geom_histogram(aes(y=after_stat("density")), # density
              bins = n_breaks))

        if input.individual_obs():
            p = p + geom_rug()

        if input.density():
            bw_adjust = input.bw_adjust()
            p = p + stat_density(adjust = bw_adjust, color = "blue")

        p = (p +
            xlab("Duration (minutes)") +
            ggtitle("Geyser eruption duration"))
        
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
            
    return None

app = App(app_ui, server)

# Can run with other name via `python inst/build_module/5_python/appHist.py`
# But need to find an unused port.
if __name__ == "__main__":
    app_run(app)
