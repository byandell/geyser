# geyser
Shiny Geyser App with and without Modules

This demonstrates how to take the [Faithful Geyser Shiny example](https://shiny.rstudio.com/gallery/faithful.html)
and modularize it, either by putting `ui()` and `server()` as functions in a separate file from `app.R` or by using the Shiny module technology. Sometimes the modular stuff is tricky to figure out.

Go into one of the first four folders and run the `app.R` file using `shiny::runApp()`.
To run the `quarto` versions, you will need to install
[Quarto](https://quarto.org/) and some packages; perhaps, see
[my quarto notes](https://github.com/byandell/quarto).

- [oldFaithful](https://github.com/byandell/geyser/tree/main/oldFaithful) (original code in one file `app.R`)
- [newFaithful](https://github.com/byandell/geyser/tree/main/newFaithful) (original code in "fake" functions)
- [callModule](https://github.com/byandell/geyser/tree/main/callModule) (demo `callModule` vs `moduleServer`)
- [moduleServer](https://github.com/byandell/geyser/tree/main/moduleServer) (full module approach using `moduleServer` and `NS` namespace)
- [quarto](https://github.com/byandell/geyser/tree/main/quarto) (Quarto version of all four above)

Useful references include the following:

- [Mastering Shiny 19: Shiny modules](https://mastering-shiny.org/scaling-modules.html)
- [Modularizing Shiny app code](https://shiny.rstudio.com/articles/modules.html)
- [My early experiments on shiny modules](https://github.com/byandell/shiny_module)
