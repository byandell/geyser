# geyser
Shiny Geyser App with and without Modules

This demonstrates how to take the [Faithful Geyser Shiny example](https://shiny.rstudio.com/gallery/faithful.html)
an modularize it, either by putting `ui()` and `server()` as functions in a separate file from `app.R` or by using the [Shiny Module technology](https://shiny.rstudio.com/articles/modules.html). Sometimes the modular stuff is tricky to figure out.

In this example, run the `app.R` (from the file, or from the console via `shiny::runApp()`) and enter either `yes` or `no` to use a simple subroutine or the more involved module technology.