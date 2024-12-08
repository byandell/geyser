# Shiny Geyser App with and without Modules

Brian Yandell, [byandell.github.io](https://byandell.github.io)

This demonstrates how to take the
[Faithful Geyser Shiny example](https://shiny.rstudio.com/gallery/faithful.html)
and modularize it, either by putting `ui()` and `server()` as functions in a
separate file from `app.R` or by using the Shiny module technology.
Sometimes the modular stuff is tricky to figure out.
For an overview, see the 
[slideDeck](https://github.com/byandell/geyser/tree/main/inst/slideDeck)
available at

- <https://connect.doit.wisc.edu/geyserShinyModules>
- <https://connect.doit.wisc.edu/geyserDemo>
- <https://connect.doit.wisc.edu/geyserQuartoDemo>

Go into one of the first four folders in
[inst/build_module](https://github.com/byandell/geyser/tree/main/inst/build_module)
and run the `app.R` file using `shiny::runApp()`.
To run the `quarto` versions, you will need to install
[Quarto](https://quarto.org/) and some packages; perhaps, see
[my quarto notes](https://github.com/byandell/quarto).
You can learn something about connecting multiple modules from examples in
[inst/connect_modules](https://github.com/byandell/geyser/tree/main/inst/connect_modules).

This repo is organized as an 
[R package](https://docs.posit.co/ide/user/ide/guide/pkg-devel/writing-packages.html).
You can explore this rep as is, mostly, but it is helpful to clone the repo
<https://github.com/byandell/geyser>
and then install the `geyser` package.

```
> library(devtools)
> install_github("byandell/geyser")
```

### Study in [Building a Module](https://github.com/byandell/geyser/tree/main/inst/build_module)

Once we have code for an app as `ui` and `server`, we can turn that into a module.
A module is a `Server` function and at least one `Input`, `Output`, and/or
`UI` functions. In addition, an `App` function enables us to test module code.
Attending to namespace conventions is important. 

1. [oldFaithful](https://github.com/byandell/geyser/tree/main/inst/build_module/1_oldFaithful)
(original code in one file `app.R`)
2. [newFaithful](https://github.com/byandell/geyser/tree/main/inst/build_module/2_newFaithful)
(original code in "fake" functions)
3. [callModule](https://github.com/byandell/geyser/tree/main/inst/build_module/3_callModule)
(demo `callModule` vs `moduleServer`)
4. [moduleServer](https://github.com/byandell/geyser/tree/main/inst/build_module/4_moduleServer)
(full module approach using `moduleServer` and `NS` namespace)

### Study in Connecting Multiple Modules

We can connect multiple modules to develop more complicated dashboards.
Again, care with namespaces is important.
This both leads to
[DRY](https://www.getdbt.com/blog/guide-to-dry)
code and increases readability, clarifying logic and points to improve
(or remedy broken) code.

- []

### References

- [Mastering Shiny 19: Shiny modules](https://mastering-shiny.org/scaling-modules.html)
- [Modularizing Shiny app code](https://shiny.rstudio.com/articles/modules.html)
- [My early experiments on shiny modules](https://github.com/byandell/shiny_module)
