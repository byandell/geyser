# Geyser Developer Guide

Welcome to the developer guide for `geyser`. This repository is a hybrid **R package** (`geyser` v0.7.2) and **Python package** (`geyser` v0.2) demonstrating [Shiny module patterns](https://mastering-shiny.org/scaling-modules.html) using the Old Faithful geyser dataset as a reference tool.

This guide clarifies the codebase structure, module boundaries, reactivity flow, cross-language parity, and local development workflows for human maintainers and AI pair-programming assistants.

---

## Table of Contents

- [Architecture Overview](#architecture-overview)
- [Repository Directory Layout](#repository-directory-layout)
- [Shiny Module Design Patterns](#shiny-module-design-patterns)
  - [R 5-Function Module Pattern](#r-5-function-module-pattern)
  - [Python Shiny Module Pattern](#python-shiny-module-pattern)
  - [R and Python Module Mapping](#r-and-python-module-mapping)
- [Environment Setup & Development Workflows](#environment-setup--development-workflows)
  - [R Package Development](#r-package-development)
  - [Python Package Development](#python-package-development)
  - [Cross-Language Interoperability & Gotchas](#cross-language-interoperability--gotchas)
- [Tutorial & Connecting Modules Layout](#tutorial--connecting-modules-layout)
  - [Progressive Tutorial (`inst/build_module`)](#progressive-tutorial-instbuild_module)
  - [Multi-Module Layouts (`inst/connect_modules`)](#multi-module-layouts-instconnect_modules)
- [Verification, Testing, and Publishing](#verification-testing-and-publishing)
- [Sub-Guides & Further Reading](#sub-guides--further-reading)

---

## Architecture Overview

`geyser` serves as an educational laboratory for modularizing Shiny web applications. It implements identical interactive components across both **R (Shiny)** and **Python (Shiny for Python)**.

```
                   +---------------------------------------+
                   |           User Interface              |
                   +-------------------+-------------------+
                                       |
                 +---------------------+---------------------+
                 |                                           |
                 v                                           v
       +-------------------+                       +-------------------+
       |     R Package     |                       |  Python Package   |
       |    (geyser R)     |                       |  (geyser Python)  |
       +---------+---------+                       +---------+---------+
                 |                                           |
                 v                                           v
       +-------------------+                       +-------------------+
       | R Shiny Modules   |                       | Python Modules    |
       | (5-func pattern)  |                       | (@module.server)  |
       +---------+---------+                       +---------+---------+
                 |                                           |
                 +---------------------+---------------------+
                                       |
                                       v
                   +---------------------------------------+
                   |       Default Dataset (faithful)      |
                   +---------------------------------------+
```

Key features of the architecture:
- **R Package**: Built following standard R package structures using `R/` source files, `DESCRIPTION`, and `NAMESPACE`.
- **Python Package**: Built as a Python package using `pyproject.toml` with module logic in `geyser/`.
- **Educational Progression**: Source code progress from monoliths to refactored functions, `callModule()`, modern `moduleServer()`, and Python equivalents.

---

## Repository Directory Layout

```text
geyser/
├── R/                              # R package source code (one file per module)
│   ├── dataApp.R                   # Data viewer / table module
│   ├── datanames.R                 # Utility to list datasets with numeric columns
│   ├── datasetsApp.R               # Dataset selector module
│   ├── gghistApp.R                 # ggplot2 histogram module
│   ├── ggpointApp.R                # ggplot2 scatter plot module
│   ├── histApp.R                   # Base R histogram module
│   ├── rowsApp.R                   # Multi-module row layout wrapper
│   ├── switchApp.R                 # Module switcher module
│   └── wrapperApp.R                # Wrapper module demo
├── geyser/                         # Python package source code
│   ├── README.md                   # Python package developer reference
│   ├── data.py                     # Python data table module
│   ├── datanames.py                # Python dataset listing helper
│   ├── datasets.py                 # Python dataset selector module
│   ├── gghist.py                   # Python plotnine/seaborn histogram module
│   ├── ggpoint.py                  # Python scatter plot module
│   ├── hist.py                     # Python matplotlib histogram module
│   ├── io.py                       # Helper utilities (app_run, r_object)
│   ├── rows.py                     # Python row layout module
│   └── switch.py                   # Python module switcher module
├── inst/                           # Installed package assets & tutorials
│   ├── build_module/               # 5-stage progressive module tutorial
│   │   ├── 1_oldFaithful/          # Stage 1: Monolithic single-file app
│   │   ├── 2_newFaithful/          # Stage 2: Refactored into UI/Server functions
│   │   ├── 3_callModule/           # Stage 3: Deprecated callModule approach
│   │   ├── 4_moduleServer/         # Stage 4: Modern moduleServer approach
│   │   └── 5_python/               # Stage 5: Python equivalent implementations
│   └── connect_modules/            # Advanced multi-module layout examples
│       ├── app.R                   # Multi-module navigation bar app
│       ├── appPages.R              # Multi-page layout
│       ├── appTwin.R               # Two identical modules sharing reactive data
│       ├── appFlip.R               # Modules with shared/flipped controls
│       ├── appDupe.R               # Duplicate module ID conflict demonstration
│       ├── python/                 # Multi-module Python scripts
│       └── quarto/                 # Quarto document versions
├── docs/                           # Documentation site & Quarto assets
│   ├── devel/                      # Detailed developer sub-guides
│   │   └── python.md               # Extensive Python Developer Guide
│   ├── geyserShinyR.qmd            # R Shiny Modules presentation slides
│   ├── geyserShinyPython.qmd       # Python Shiny Modules presentation slides
│   └── gallery.html                # Interactive Shinylive gallery
├── vignettes/                      # R package vignettes
│   └── DeveloperGuide.Rmd          # Master R Vignette Developer Guide
├── DESCRIPTION                     # R package metadata
├── NAMESPACE                       # R exported function declarations
├── pyproject.toml                  # Python package configuration
├── module.md                       # Comprehensive Shiny module tutorial text
├── publish.md                      # Deployment & GitHub Pages instructions
├── README.md                       # Main repository landing page
└── AGENTS.md                       # Project rules & AI instructions
```

---

## Shiny Module Design Patterns

### R 5-Function Module Pattern

Every R module in `R/` strictly follows a standardized **5-function pattern**:

| Function Signature | Role & Scope | Namespace Requirement |
|---|---|---|
| `moduleNameInput("id")` | UI control elements | Wrapped with `NS(id)` |
| `moduleNameOutput("id")` | Output display placeholders | Wrapped with `NS(id)` |
| `moduleNameUI("id")` | Combined or dynamic UI layout | Wrapped with `NS(id)` |
| `moduleNameServer("id", data)` | Reactive server business logic | Uses `moduleServer(id, function(input, output, session) {...})` |
| `moduleNameApp(data)` | Standalone test wrapper app | Standard `shinyApp(ui, server)` (no `ns()` at top level) |

#### R Module Code Skeleton (`R/histApp.R` Example)

```r
# 1. Input UI
histInput <- function(id) {
  ns <- NS(id)
  tagList(
    sliderInput(ns("bins"), "Number of bins:", min = 1, max = 50, value = 30)
  )
}

# 2. Output UI
histOutput <- function(id) {
  ns <- NS(id)
  plotOutput(ns("distPlot"))
}

# 3. Combined UI
histUI <- function(id) {
  ns <- NS(id)
  sidebarLayout(
    sidebarPanel(histInput(id)),
    mainPanel(histOutput(id))
  )
}

# 4. Server Logic
histServer <- function(id, dataset = reactive(faithful)) {
  moduleServer(id, function(input, output, session) {
    output$distPlot <- renderPlot({
      x <- dataset()[, 1]
      bins <- seq(min(x), max(x), length.out = input$bins + 1)
      hist(x, breaks = bins, col = "darkgray", border = "white")
    })
  })
}

# 5. Standalone App Wrapper
histApp <- function(dataset = faithful) {
  ui <- fluidPage(histUI("hist"))
  server <- function(input, output, session) {
    histServer("hist", dataset = reactive(dataset))
  }
  shinyApp(ui, server)
}
```

---

### Python Shiny Module Pattern

Python Shiny modules use function-based UI functions and the `@module.server` decorator from `shiny.module`.

#### Python Module Code Skeleton (`geyser/hist.py` Example)

```python
from shiny import module, ui, render, reactive
import matplotlib.pyplot as plt
from geyser.io import app_run

# 1. Module UI
@module.ui
def hist_ui():
    return ui.layout_sidebar(
        ui.sidebar(
            ui.input_slider("bins", "Number of bins:", 1, 50, 30)
        ),
        ui.output_plot("distPlot")
    )

# 2. Module Server
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

# 3. Standalone App Runner
def app_hist(dataset=None):
    from geyser.io import r_object
    if dataset is None:
        dataset = r_object('faithful')
    
    app_ui = ui.page_fluid(hist_ui("hist"))
    def server(input, output, session):
        hist_server("hist", dataset=reactive.value(dataset))
    
    app = ui.ShinyApp(app_ui, server)
    app_run(app)
    return app
```

---

### R and Python Module Mapping

| Component | R Implementation (`R/`) | Python Implementation (`geyser/`) | Primary Purpose |
|---|---|---|---|
| **Base Histogram** | `histApp.R` | `hist.py` | Base graphics histogram |
| **ggplot Histogram** | `gghistApp.R` | `gghist.py` | Grammar of graphics histogram |
| **Scatter Plot** | `ggpointApp.R` | `ggpoint.py` | Bivariate scatter plot |
| **Dataset Selector** | `datasetsApp.R` | `datasets.py` | Select numeric datasets |
| **Data Viewer** | `dataApp.R` | `data.py` | Interactive data table (`DT` / `render.data_frame`) |
| **Row Layout** | `rowsApp.R` | `rows.py` | Multi-module horizontal row layout |
| **Module Switcher** | `switchApp.R` | `switch.py` | Dynamic module navigation / tab switching |
| **Wrapper Module** | `wrapperApp.R` | — | Example of module wrapping another module |
| **Dataset Utility** | `datanames.R` | `datanames.py` | List numeric dataset names |
| **I/O & Port Helper** | — | `io.py` | `app_run()` free port discovery & `r_object()` |

---

## Environment Setup & Development Workflows

### R Package Development

#### Requirements
- R >= 4.2.0
- Dependencies: `bslib`, `dplyr`, `DT`, `ggplot2`, `graphics`, `rlang`, `shiny`, `stats`, `stringr`, `tibble`

#### Interactive R Workflow
```r
# Load all functions into local environment during dev
devtools::load_all()

# Run a specific module standalone app
histApp()
datasetsApp()

# Re-generate documentation in man/
devtools::document()

# Run full package checks
devtools::check()
```

---

### Python Package Development

#### Requirements
- Python >= 3.8 (Python 3.12 recommended)
- Dependencies: `shiny`, `matplotlib`, `numpy`, `scipy`, `pandas`, `nest_asyncio`, `rpy2`

#### Local Python Setup
```bash
# Clone and install package in editable mode
git clone https://github.com/byandell/geyser.git
cd geyser
pip install -e .

# Test Python modules directly
python -c "import geyser; geyser.hist.app_hist()"
```

---

### Cross-Language Interoperability & Gotchas

1. **Port Discovery (`geyser.io.app_run`)**:
   - In Python, running multiple Shiny apps within interactive sessions can conflict on default ports.
   - Use `geyser.io.app_run(app)` which uses standard socket binding (`s.bind(('', 0))`) to auto-allocate an available free port.

2. **Reserved Filenames in Quarto**:
   - **Do NOT name Python Shiny scripts `app.py`** if stored in directories that contain Quarto documents. Quarto reserves `app.py` for Python Shinylive rendering and will throw deployment conflicts. Use names like `app_hist.py` or `app_demo.py`.

3. **Namespace Scoping**:
   - R uses `ns <- NS(id)` explicitly for inputs and outputs in UI functions.
   - Python `@module.ui` automatically scopes input IDs inside the decorated function.

4. **Data Exchange (`rpy2`)**:
   - The Python utility `geyser.io.r_object('faithful')` uses `rpy2` to fetch R built-in datasets directly into `pandas.DataFrame` objects for feature parity.

---

## Tutorial & Connecting Modules Layout

### Progressive Tutorial (`inst/build_module`)

`inst/build_module/` guides developers through the 5 architectural stages of Shiny module refactoring:

1. `1_oldFaithful/`: Monolithic app (`ui` and `server` in single script).
2. `2_newFaithful/`: Logic extracted into custom functions (without module namespaces).
3. `3_callModule/`: Historical module approach using deprecated `callModule()`.
4. `4_moduleServer/`: Modern module approach using `moduleServer()` and `NS()`.
5. `5_python/`: Python implementations matching Stage 4.

### Multi-Module Layouts (`inst/connect_modules`)

`inst/connect_modules/` demonstrates advanced composition patterns:
- **Central Data Routing (`app.R`)**: Connecting `datasetsServer` to `histServer`, `gghistServer`, and `ggpointServer`.
- **Multi-page navigation (`appPages.R`)**: Rendering modules inside tabbed panels.
- **Shared Reactive State (`appTwin.R`)**: Two independent visualizer modules consuming the same reactive dataset.
- **Duplicate ID Traps (`appDupe.R`)**: Illustrates common mistake when identical module IDs are instantiated twice in one session.

---

## Verification, Testing, and Publishing

### Testing Modules
- **R Modules**: Test individual modules by calling `moduleNameApp()`.
- **Python Modules**: Run standalone test launchers `python -m geyser.hist` or scripts in `inst/build_module/5_python/`.

### Documentation Site & Shinylive
The repository documentation and interactive Shinylive demos are rendered in `docs/` using Quarto:
```bash
# Render Quarto site locally
quarto render docs/
```
See [publish.md](publish.md) for GitHub Pages publishing details.

---

## Sub-Guides & Further Reading

For deeper language-specific sub-guides and detailed documentation:
- 📖 **[R Vignette Developer Guide](vignettes/DeveloperGuide.Rmd)** (`vignettes/DeveloperGuide.Rmd`) | [(GitHub Source)](https://github.com/byandell/geyser/blob/main/vignettes/DeveloperGuide.Rmd)
- 🐍 **[Python Developer Guide](docs/devel/python.md)** (`docs/devel/python.md`) | [(GitHub Source)](https://github.com/byandell/geyser/blob/main/docs/devel/python.md)
- 📦 **[Python Package README](geyser/README.md)** (`geyser/README.md`) | [(GitHub Source)](https://github.com/byandell/geyser/blob/main/geyser/README.md)
- 🎓 **[Shiny Module Tutorial](module.md)** (`module.md`) | [(GitHub Source)](https://github.com/byandell/geyser/blob/main/module.md)
- 🚀 **[Publishing & GitHub Pages Guide](publish.md)** (`publish.md`) | [(GitHub Source)](https://github.com/byandell/geyser/blob/main/publish.md)
