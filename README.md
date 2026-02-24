# Shiny Geyser App with and without Modules

Brian Yandell, [byandell.github.io](https://byandell.github.io)

This demonstrates how to take the
[Faithful Geyser Shiny example](https://shiny.rstudio.com/gallery/faithful.html)
and modularize it, either by putting `ui()` and `server()` as functions in a
separate file from `app.R` or by using the Shiny module technology.
Sometimes the modular stuff is tricky to figure out.

This repo is organized as both an
[R package](https://docs.posit.co/ide/user/ide/guide/pkg-devel/writing-packages.html)
and a
[Python package](https://packaging.python.org/en/latest/tutorials/packaging-projects/).
You can explore this repo as is online
or clone the repo
<https://github.com/byandell/geyser>.
Alternatively, you can install in `R`

```{r}
library(devtools)
install_github("byandell/geyser")
```

and/or in `Python`.

```{python}
#| eval: False
pip install --quiet git+https://github.com/byandell/geyser.git
```

See
[Shiny Geyser App with and without Modules](module.md)
for detailed information about layout, tutorials and code.
