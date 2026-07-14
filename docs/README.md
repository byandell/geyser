# `geyser`: Shiny Module Demo

This repo demonstrates how to modularize the
[Faithful Geyser Shiny example](https://shiny.rstudio.com/gallery/faithful.html)
using the
[Shiny module technology](https://mastering-shiny.org/scaling-modules.html).
Sometimes this module stuff is tricky to figure out.

- [Slide Decks](#slide-decks)
- [Demos](#demos)
  - [ShinyLive Demos](#shinylive-demos)
- [R and Python Package Layouts](#r-and-python-package-layouts)
- [Shiny Reactlog](#shiny-reactlog)

*[GitHub](https://github.com/byandell/geyser)*

## Slide Decks

Slide decks were developed using
[Quarto](https://quarto.org/).

- [geyserShinyR](./geyserShinyR.html) ([source](https://github.com/byandell/geyser/blob/main/docs/geyserShinyR.qmd))
- [geyserShinyPython](./geyserShinyPython.html) ([source](https://github.com/byandell/geyser/blob/main/docs/geyserShinyPython.qmd))

Earlier versions of these slide decks are available from [Posit Connect](https://it.wisc.edu/services/data-science-platform-posit-connect/):  

- <https://connect.doit.wisc.edu/geyserShinyModules>
- <https://connect.doit.wisc.edu/slidesPythonModules>

## Demos

Live demos rendered with GitHub Pages:

- [`geyser` demos](demos/) ([source](https://github.com/byandell/geyser/blob/main/docs/demos/index.qmd)) ([prompt](https://byandell.github.io/Documentation/prompts/gallery.html))
  - [Build Module](demos/build_module.html) ([source](https://github.com/byandell/geyser/blob/main/docs/demos/build_module.qmd)) ([code](https://github.com/byandell/geyser/blob/main/inst/build_module/4_moduleServer/app.R))
  - [Connect Modules](demos/connect_modules.html) ([source](https://github.com/byandell/geyser/blob/main/docs/demos/connect_modules.qmd)) ([code](https://github.com/byandell/geyser/blob/main/inst/connect_modules/app.R))
  - [Python Module](demos/python_module.html) ([source](https://github.com/byandell/geyser/blob/main/docs/demos/python_module.qmd)) ([code](https://github.com/byandell/geyser/blob/main/inst/build_module/5_python/app_hist.py))
  - [Quarto](demos/quarto.html) ([source](https://github.com/byandell/geyser/blob/main/docs/demos/quarto.qmd)) ([code](https://github.com/byandell/geyser/blob/main/inst/connect_modules/quarto/demo.qmd))
  - [Posit Gallery](demos/posit_gallery.html) ([source](https://github.com/byandell/geyser/blob/main/docs/demos/posit_gallery.qmd))

Live demos are also available via [Posit Connect](https://it.wisc.edu/services/data-science-platform-posit-connect/).

- <https://connect.doit.wisc.edu/geyserDemo> (see
[inst/connect_modules/app.R](https://github.com/byandell/geyser/blob/main/inst/connect_modules/app.R))
- <https://connect.doit.wisc.edu/geyserQuartoDemo> (see
[inst/connect_modules/quarto/demo.qmd](https://github.com/byandell/geyser/blob/main/inst/connect_modules/quarto/demo.qmd))

The following presentation demonstrates R Shiny apps and their modules
using the
[geyserShinyR](./geyserShinyR.html)
slide deck.

- [11 Dec 2024 Presentation](https://github.com/byandell/geyser/tree/main/R_Shiny_Club_20241211_Yandell)

### ShinyLive Demos

I built demos on GitHub Pages using
[shinylive](https://shiny.posit.co/py/get-started/shinylive.html).
See
[Showcase Shiny Apps and Code](https://byandell.github.io/Documentation/prompts/gallery.html)
and
[Deploy GitHub Pages via GitHub Actions](https://byandell.github.io/Documentation/github/actions.html)
for more information.

## R and Python Package Layouts

The repo has both an
[R](https://docs.posit.co/ide/user/ide/guide/pkg-devel/writing-packages.html)
and
[Python](https://packaging.python.org/en/latest/tutorials/packaging-projects/)
package.
The `R` package is organized as

```
R package
├── DESCRIPTION
├── NAMESPACE
├── R/
│   └── *.R
├── man/
└── inst/
```

The `Python` package is organized as follows

```
Python package
├── pyproject.toml
├── geyser
│   ├── __init__.py
│   └── *.py
```

Examples in `R`, `Python` and `Quarto` are strewn through the `inst/` directory:

```
inst/
├── build_module/
│   ├── 1_oldFaithful/
│   │   ├── *.R
│   │   └── *.qmd
│   ├── 2_newFaithful/
│   │   ├── *.R
│   │   └── *.qmd
│   ├── 3_callModule/
│   │   ├── *.R
│   │   └── *.qmd
│   ├── 4_moduleServer/
│   │   ├── *.R
│   │   └── *.qmd
│   └── 5_python/
│       ├── *.py
│       └── *.qmd
├── connect_modules/
│   ├── *.R
│   ├── python/
│   │   └── *.py
│   └── quarto/
│       └── *.qmd
└── reactlog/
```

## Shiny Reactlog

The
[inst/reactlog](https://github.com/byandell/geyser/tree/main/inst/reactlog)
directory contains examples of using
[reactlog](https://rstudio.github.io/reactlog/) with
Shiny apps to track reactivity of an app
across its components.
