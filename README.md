# geyser
Shiny Geyser App with and without Modules

This demonstrates how to take the [Faithful Geyser Shiny example](https://shiny.rstudio.com/gallery/faithful.html)
and modularize it, either by putting `ui()` and `server()` as functions in a separate file from `app.R` or by using the Shiny module technology. Sometimes the modular stuff is tricky to figure out.

Go into one of the folders and run the `app.R` file using `shiny::runApp()`

- [faithful](https://github.com/byandell/geyser/tree/main/faithful) (original code just organized into functions)
- [modular](https://github.com/byandell/geyser/tree/main/modular) (reorganized using modules circa 2015 with callModule)
- [geyser](https://github.com/byandell/geyser/tree/main/geyser) (modern approach using serverModule and naming)

Useful references include the following:

- [Mastering Shiny 19: Shiny modules](https://mastering-shiny.org/scaling-modules.html)
- [Modularizing Shiny app code](https://shiny.rstudio.com/articles/modules.html)
- [My early experiments on shiny modules](https://github.com/byandell/shiny_module)
