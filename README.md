# geyser
Shiny Geyser App with and without Modules

This demonstrates how to take the [Faithful Geyser Shiny example](https://shiny.rstudio.com/gallery/faithful.html)
and modularize it, either by putting `ui()` and `server()` as functions in a separate file from `app.R` or by using the [Shiny Module technology](https://shiny.rstudio.com/articles/modules.html). Sometimes the modular stuff is tricky to figure out.

Go into one of the folders and run the `app.R` file using `shiny::runApp()`

- faithful (original code just organized into functions)
- modular (reorganized using modules circa 2015 with callModule)
- geyser (modern approach using serverModule and naming)
