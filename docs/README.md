# `geyser` Slide Decks and Demos

This repo demonstrates how to modularize the
[Faithful Geyser Shiny example](https://shiny.rstudio.com/gallery/faithful.html)
using the
[Shiny module technology](https://mastering-shiny.org/scaling-modules.html).
Sometimes this module stuff is tricky to figure out.

- [Slide Decks](#slide-decks)
- [Demos](#demos)
  - [ShinyLive Demos](#shinylive-demos)
- [R and Python Packages](#r-and-python-packages)
- [Shiny Reactlog](#shiny-reactlog)

*[GitHub](https://github.com/byandell/geyser)*

## Slide Decks

Slide decks were developed using
[Quarto](https://quarto.org/).

- [geyserShinyR](./geyserShinyR.html) ([`qmd`](https://github.com/byandell/geyser/blob/main/docs/geyserShinyR.qmd))
- [geyserShinyPython](./geyserShinyPython.html) ([`qmd`](https://github.com/byandell/geyser/blob/main/docs/geyserShinyPython.qmd))

Earlier versions of these slide decks are available from [Posit Connect](https://it.wisc.edu/services/data-science-platform-posit-connect/):  

- <https://connect.doit.wisc.edu/geyserShinyModules>
- <https://connect.doit.wisc.edu/slidesPythonModules>

## Demos

Live demos are available via [Posit Connect](https://it.wisc.edu/services/data-science-platform-posit-connect/).

- <https://connect.doit.wisc.edu/geyserDemo> (see
[inst/connect_modules/app.R](https://github.com/byandell/geyser/blob/main/inst/connect_modules/app.R))
- <https://connect.doit.wisc.edu/geyserQuartoDemo> (see
[inst/connect_modules/quarto/demo.qmd](https://github.com/byandell/geyser/blob/main/inst/connect_modules/quarto/demo.qmd))

The following presentation demonstrates R Shiny apps and their modules
using the
[geyserShinyR](./geyserShinyR.html)
slide deck.

- [11 Dec 2024 Presentation](R_Shiny_Club_20241211_Yandell/README.md)

### ShinyLive Demos

I am woking on building these demos on GitHub Pages using
[r-shinylive](https://posit-dev.github.io/r-shinylive/)
and
[Using Shinylive to host Shiny app on GitHub Pages (HBC Training)](https://hbctraining.github.io/Training-modules/RShiny/lessons/shinylive.html).

```R
install.packages(".", repos = NULL, type = "source")
shinylive::export(appdir = "inst/connect_modules/", destdir = "~/docs")
# should create ~/docs/app.json
httpuv::runStaticServer("~/docs")
```

For Python, see
[py-shinylive](https://github.com/posit-dev/py-shinylive) and
[Python Shinylive: Shiny + WebAssembly (Posit)](https://shiny.posit.co/py/get-started/shinylive.html).

## R and Python Packages

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

The Python package is organized as follows

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
