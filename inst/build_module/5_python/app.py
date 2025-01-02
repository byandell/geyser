# This file generated by Quarto; do not edit by hand.
# shiny_mode: core

from __future__ import annotations

from pathlib import Path
from shiny import App, Inputs, Outputs, Session, ui

import seaborn as sns
from shiny import reactive, render, ui
penguins = sns.load_dataset("penguins")

# ========================================================================




def server(input: Inputs, output: Outputs, session: Session) -> None:
    species = list(penguins["species"].value_counts().index)
    ui.input_checkbox_group(
        "species", "Species:",
        species, selected = species
    )

    islands = list(penguins["island"].value_counts().index)
    ui.input_checkbox_group(
        "islands", "Islands:",
        islands, selected = islands
    )

    @reactive.calc
    def filtered_penguins():
        data = penguins[penguins["species"].isin(input.species())]
        data = data[data["island"].isin(input.islands())]
        return data

    # ========================================================================

    ui.input_select("dist", "Distribution:", choices=["kde", "hist"])
    ui.input_checkbox("rug", "Show rug marks", value = False)

    # ========================================================================

    @render.plot
    def depth():
        return sns.displot(
            filtered_penguins(), x = "bill_depth_mm",
            hue = "species", kind = input.dist(),
            fill = True, rug=input.rug()
        )

    # ========================================================================

    @render.plot
    def length():
        return sns.displot(
            filtered_penguins(), x = "bill_length_mm",
            hue = "species", kind = input.dist(),
            fill = True, rug=input.rug()
        )

    # ========================================================================

    @render.data_frame
    def dataview():
        return render.DataGrid(filtered_penguins())

    # ========================================================================



    return None


_static_assets = ["PalmerPenguins_files","PalmerPenguins_files/libs/quarto-html/tippy.css","PalmerPenguins_files/libs/quarto-html/quarto-syntax-highlighting-07ba0ad10f5680c660e360ac31d2f3b6.css","PalmerPenguins_files/libs/bootstrap/bootstrap-icons.css","PalmerPenguins_files/libs/bootstrap/bootstrap-904b8a07dbe7a1431ee957d984fa9fcb.min.css","PalmerPenguins_files/libs/quarto-dashboard/datatables.min.css","PalmerPenguins_files/libs/clipboard/clipboard.min.js","PalmerPenguins_files/libs/quarto-html/quarto.js","PalmerPenguins_files/libs/quarto-html/popper.min.js","PalmerPenguins_files/libs/quarto-html/tippy.umd.min.js","PalmerPenguins_files/libs/quarto-html/anchor.min.js","PalmerPenguins_files/libs/bootstrap/bootstrap.min.js","PalmerPenguins_files/libs/quarto-dashboard/quarto-dashboard.js","PalmerPenguins_files/libs/quarto-dashboard/stickythead.js","PalmerPenguins_files/libs/quarto-dashboard/datatables.min.js","PalmerPenguins_files/libs/quarto-dashboard/pdfmake.min.js","PalmerPenguins_files/libs/quarto-dashboard/vfs_fonts.js","PalmerPenguins_files/libs/quarto-dashboard/web-components.js","PalmerPenguins_files/libs/quarto-dashboard/components.js"]
_static_assets = {"/" + sa: Path(__file__).parent / sa for sa in _static_assets}

app = App(
    Path(__file__).parent / "PalmerPenguins.html",
    server,
    static_assets=_static_assets,
)
