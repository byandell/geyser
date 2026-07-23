# Python Developer Guide for `geyser`

This guide provides extensive technical details for developers extending, debugging, or building Python Shiny applications and modules within the `geyser` hybrid repository.

---

## Package Architecture (`geyser/`)

The Python package source code is housed in the `geyser/` sub-directory:

```text
geyser/
├── __init__.py           # Package imports and exports
├── README.md             # Sub-directory developer reference
├── datanames.py          # Utility to list available dataset names
├── datasets.py           # Dataset selector module (@module.ui & @module.server)
├── data.py               # Data table viewer module
├── hist.py               # Matplotlib histogram module
├── gghist.py             # Plotnine/Seaborn histogram module
├── ggpoint.py            # Scatter plot module
├── rows.py               # Multi-module row layout container
├── switch.py             # Dynamic module switcher container
└── io.py                 # I/O utilities (app_run & r_object)
```

---

## Module Architecture & Reactivity

In Python Shiny, modules are constructed using two core decorators from `shiny.module`:

1. **`@module.ui`**: Defines the user interface layout. Input controls inside this decorated function are automatically namespaced.
2. **`@module.server`**: Encapsulates reactive server logic.

### 1. The `@module.ui` Decorator

```python
from shiny import module, ui

@module.ui
def hist_ui():
    return ui.layout_sidebar(
        ui.sidebar(
            ui.input_slider("bins", "Number of bins:", 1, 50, 30)
        ),
        ui.output_plot("distPlot")
    )
```

> **Scoping Note**: Unlike R where `ns <- NS(id)` must be explicitly wrapped around input IDs (`ns("bins")`), Python's `@module.ui` automatically scopes input IDs (`bins` becomes `module_id-bins` internally).

### 2. The `@module.server` Decorator

```python
from shiny import module, render, reactive
import matplotlib.pyplot as plt

@module.server
def hist_server(input, output, session, dataset=reactive.value(None)):
    @render.plot
    def distPlot():
        df = dataset()
        if df is None:
            return None
        x = df.iloc[:, 0]
        fig, ax = plt.subplots()
        ax.hist(x, bins=input.bins(), color="darkgray", edgecolor="white")
        return fig
```

---

## I/O & Port Management (`geyser.io`)

### Automatic Free Port Discovery (`app_run`)

When running interactive Python Shiny applications, port collisions can occur when launching multiple sessions. `geyser.io.app_run` binds to port `0` to dynamically ask the OS for an open port before starting the server.

```python
from geyser.io import app_run
from shiny import ui

app = ui.ShinyApp(ui.page_fluid(), server_func)
app_run(app)
```

### Retrieving R Data into Python (`r_object`)

To ensure data parity with the R package, `geyser.io.r_object` utilizes `rpy2` to pull R datasets (such as `faithful`) directly into `pandas.DataFrame` objects:

```python
from geyser.io import r_object

faithful_df = r_object("faithful")
print(faithful_df.head())
```

---

## Standalone Module Launchers

Each module in `geyser` provides a standalone app runner function (e.g., `app_hist()`, `app_datasets()`, `app_rows()`).

To test a module standalone:
```python
import geyser.hist
geyser.hist.app_hist()
```

---

## Quarto & Shinylive Integration

### Reserved Filename Rules
When placing Python Shiny apps in directories that contain Quarto documents (`.qmd`), **never name your script `app.py`**. Quarto reserves `app.py` for its internal Python web deployment pipeline. Always use explicit names like `app_hist.py` or `app_demo.py`.

### Shinylive Python Deployment
Python modules in `geyser` can be compiled to WebAssembly via Shinylive using:
```bash
quarto render docs/
```
The resulting web assets are output to `docs/` for GitHub Pages hosting.
