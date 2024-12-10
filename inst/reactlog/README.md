# inst/reactlog/README.md 

- Read [Shiny Reactlog](https://rstudio.github.io/reactlog/articles/reactlog.html) article.
- See [inst/reactlog](https://github.com/byandell/geyser/blob/main/inst/reactlog) examples saved as `RDS` objects.
- Re-open repo to reset `reactlog` before enabling.

### Examples in the folder:

- [inst/reactlog/geyser.rds](https://github.com/byandell/geyser/blob/main/inst/reactlog/geyser.rds):
modular version of old Faithful in
[inst/build_module/4_moduleServer](https://github.com/byandell/geyser/blob/main/inst/build_module/4_moduleServer).
- [inst/reactlog/pages.rds](https://github.com/byandell/geyser/blob/main/inst/reactlog/pages.rds):
`navBar` pages with code
[inst/connect_modules/appPages.R](https://github.com/byandell/geyser/blob/main/inst/connect_modules/appPages.R).
- [inst/reactlog/demo.rds](https://github.com/byandell/geyser/blob/main/inst/reactlog/demo.rds):
[Geyser Shiny Demo](https://connect.doit.wisc.edu/geyserDemo) with code
[inst/connect_modules/app.R](https://github.com/byandell/geyser/blob/main/inst/connect_modules/app.R).

### Example code:

```
# Enable `reactlog` and run app.
reactlog::reactlog_enable()
shiny::runApp("inst/build_module/4_moduleServer")

# Show `reactlog` in browser.
shiny::reactlogShow()

# Save log of reactive session.
geyser_log <- shiny::reactlog()
saveRDS(geyser_log, "inst/reactlog/geyser.rds")

# Retrieve previously saved reactive session.
geyser_log <- readRDS("inst/reactlog/geyser.rds")
reactlog::reactlog_show(geyser_log)
```

