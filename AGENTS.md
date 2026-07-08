# Geyser Project Memory

## Overview

R package (and Python companion) demonstrating Shiny module patterns using the Old Faithful geyser dataset as a teaching tool.

- **R Package**: `geyser` v0.7.2
- **Python Package**: `geyser` v0.2
- **GitHub**: https://github.com/byandell/geyser
- **Website**: https://byandell.github.io/geyser

## Loading / Installation

```r
# Development (local)
devtools::load_all()

# From GitHub
devtools::install_github("byandell/geyser")
library(geyser)
```

## Key Exports

Each module follows a standard 5-function pattern: `Input`, `Output`, `UI`, `Server`, `App`.

| Module | Purpose |
|---|---|
| `histApp()` | Base R histogram |
| `gghistApp()` | ggplot2 histogram |
| `ggpointApp()` | ggplot2 scatter plot |
| `datasetsApp()` | Dataset selector (any R dataset with numeric cols) |
| `dataApp()` | Data viewer / table |
| `rowsApp()` | Multiple modules in row layout |
| `switchApp()` | Module switching demo |
| `wrapperApp()` | Wrapper module example |

`datanames()` — utility that lists R `datasets` package datasets with numeric columns.

## Module Pattern

```r
moduleNameInput("id")   # UI controls (uses NS)
moduleNameOutput("id")  # Output placeholder
moduleNameUI("id")      # Conditional/dynamic UI
moduleNameServer("id", data = reactive(faithful))  # Reactive logic
moduleNameApp()         # Standalone test wrapper
```

## Default Data

- **faithful** — Old Faithful (eruptions, waiting); default for most modules
- Any R built-in dataset with numeric columns is selectable via `datasetsApp()`

## Project Structure

```
R/                        # R package source (one file per module)
geyser/                   # Python package source
inst/
  build_module/           # Progressive tutorial (4 stages + Python)
    1_oldFaithful/        # Monolithic app (starting point)
    2_newFaithful/        # Refactored into functions
    3_callModule/         # Deprecated callModule() approach
    4_moduleServer/       # Modern moduleServer() (current best practice)
    5_python/             # Python equivalents
  connect_modules/        # Advanced: connecting multiple modules together
    app.R                 # NavBar with 5+ modules
    appPages.R            # Multi-page layout
    appTwin.R             # Two identical modules sharing data
    appFlip.R             # Modules with shared/flipped controls
    appDupe.R             # Common mistake: duplicate ID issue
    quarto/               # Quarto document versions
man/                      # roxygen2-generated Rd docs
```

## Dependencies

**R** (>= 4.2.0): bslib, dplyr, DT, ggplot2, graphics, rlang, shiny, stats, stringr, tibble

**Python** (>= 3.8): matplotlib, nest_asyncio, numpy, rpy2, scipy, shiny

## Connecting Multiple Modules

```r
server <- function(input, output, session) {
  dataset <- datasetsServer("datasets")   # central reactive dataset
  histServer("hist", dataset)
  gghistServer("gghist", dataset)
  ggpointServer("ggpoint", dataset)
}
```

## Notes

- Always wrap input IDs with `ns()` inside Input functions; omit in standalone App functions.
- Same module ID used twice in one app causes conflicts (see `appDupe.R`).
- Python: avoid naming files `app.py` — Quarto reserves that name. Use `app_hist.py`, etc.
- Python apps: use `geyser.io.app_run()` to auto-discover a free port.
- Documentation: `module.md` is the main tutorial reference (190 lines).
