### Python Module (`penguin_module.py`)

from shiny import module, render, reactive, ui
import seaborn as sns

penguins = sns.load_dataset("penguins")

# Define the input part of the module
@module.ui
def penguin_input_ui():
    return ui.div(
        ui.input_select("x", "Variable:", choices=["bill_length_mm", "bill_depth_mm"]),
        ui.input_select("dist", "Distribution:", choices=["hist", "kde"]),
        ui.input_checkbox("rug", "Show rug marks", value=False)
    )

# Define the server logic for the module
@module.server
def penguin_server(input, output, session):
    @render.plot
    def displot():
        sns.displot(
            data=penguins, hue="species", multiple="stack",
            x=input.x(), rug=input.rug(), kind=input.dist()
        )