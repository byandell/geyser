# Geyser Slide Decks

## Slide Decks

Slide decks were developed using
[Quarto](https://quarto.org/);
see code in
[docs](./docs).

- [geyserShinyR](./geyserShinyR.html)
- [geyserShinyPython](./geyserShinyPython.html)

Earlier slide decks are available from [Posit Connect](https://it.wisc.edu/services/data-science-platform-posit-connect/):  

- <https://connect.doit.wisc.edu/geyserShinyModules>
- <https://connect.doit.wisc.edu/slidesPythonModules>

## Demos

Live demos are available via [Posit Connect](https://it.wisc.edu/services/data-science-platform-posit-connect/).
I am woking on building these via GitHub using
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
or

- <https://connect.doit.wisc.edu/geyserDemo> (see
[inst/connect_modules/app.R](https://github.com/byandell/geyser/blob/main/inst/connect_modules/app.R))
- <https://connect.doit.wisc.edu/geyserQuartoDemo> (see
[inst/connect_modules/quarto/demo.qmd](https://github.com/byandell/geyser/blob/main/inst/connect_modules/quarto/demo.qmd))

The following presentation demonstrates R Shiny apps and their modules
using the Old Faithful geyser data.

- [11 Dec 2024 Presentation](R_Shiny_Club_20241211_Yandell/README.md)
