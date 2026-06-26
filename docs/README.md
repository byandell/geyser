# `geyser` Slide Decks and Demos

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

Live demos rendered with GitHub Pages are.

- [geyserDemo](shiny/) ([source](https://github.com/byandell/geyser/blob/main/inst/connect_modules/app.R))
- [geyserQuartoDemo](demo_shinylive.html) ([source](https://github.com/byandell/geyser/blob/main/docs/demo_shinylive.qmd))

Live demos are also available via [Posit Connect](https://it.wisc.edu/services/data-science-platform-posit-connect/).

- <https://connect.doit.wisc.edu/geyserDemo> (see
[inst/connect_modules/app.R](https://github.com/byandell/geyser/blob/main/inst/connect_modules/app.R))
- <https://connect.doit.wisc.edu/geyserQuartoDemo> (see
[inst/connect_modules/quarto/demo.qmd](https://github.com/byandell/geyser/blob/main/inst/connect_modules/quarto/demo.qmd))

The following presentation demonstrates R Shiny apps and their modules
using the
[geyserShinyR](./geyserShinyR.html)
slide deck.

- [11 Dec 2024 Presentation](../R_Shiny_Club_20241211_Yandell/README.md)

### ShinyLive Demos

I tried building these demos on GitHub Pages using
`shinylive` for the demo app in
[inst/connect_modules](https://github.com/byandell/geyser/tree/main/inst/connect_modules)
shown above.
For more information, see

- [Prepare R app for Shinylive Export](https://byandell.github.io/Documentation/github/shinylive.html)
- [Quarto Dashboard Shinylive](https://byandell.github.io/Documentation/github/quartolive.html)
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
