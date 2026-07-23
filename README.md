# Shiny Geyser App with and without Modules

*[byandell.github.io/geyser](https://byandell.github.io/geyser)*

This repo demonstrates how to take the [Faithful Geyser Shiny example](https://shiny.rstudio.com/gallery/faithful.html) and modularize it, either by putting `ui()` and `server()` as functions in a separate file from `app.R` or by using [Shiny module technology](https://mastering-shiny.org/scaling-modules.html).

This repo is organized as both an [R package](https://docs.posit.co/ide/user/ide/guide/pkg-devel/writing-packages.html) and a [Python package](https://packaging.python.org/en/latest/tutorials/packaging-projects/). You can explore this repo online or clone the repo at <https://github.com/byandell/geyser>.

## Quick Installation

### R Package

```r
# Install via pak
pak::pak("byandell/geyser")
```

### Python Package

```bash
pip install --quiet git+https://github.com/byandell/geyser.git
```

## Exploring the Repo

- **Developer Guides**:
  - [Architectural Overview (DEVELOPER.md)](DEVELOPER.md) | [(GitHub source)](https://github.com/byandell/geyser/blob/main/DEVELOPER.md)
  - [R Developer Guide (vignettes/DeveloperGuide.Rmd)](vignettes/DeveloperGuide.Rmd) | [(GitHub source)](https://github.com/byandell/geyser/blob/main/vignettes/DeveloperGuide.Rmd)
  - [Python Developer Guide (docs/devel/python.md)](docs/devel/python.md) | [(GitHub source)](https://github.com/byandell/geyser/blob/main/docs/devel/python.md)
- **[Guides Record](guides.md)**: Combined blueprint prompts, implementation plan, and walkthrough record.
- **[Module Guide](module.md)**: Detailed tutorial on Shiny modules in R and Python.
- **[Publish Update](./publish.md)**: Update about publishing the repo via GitHub Pages.
- **[Documentation & Slides](docs/README.md)**: Presentations and documentation.
  - [R Shiny Modules Presentation](docs/geyserShinyR.qmd)
  - [Python Shiny Modules Presentation](docs/geyserShinyPython.qmd)
- **[Demos Gallery](docs/demos/index.qmd)**: Interactive Shinylive modules running directly in your browser.
- **Tutorial Code**: Sample Shiny module code in `inst/build_module` and `inst/connect_modules`.
- **[Video Tutorial](R_Shiny_Club_20241211_Yandell/README.md)**: Presentation recording and resources.
