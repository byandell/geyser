# inst/reactlog/README.md 

- Read [Shiny Reactlog](https://rstudio.github.io/reactlog/articles/reactlog.html) article.
- See [inst/reactlog](https://github.com/byandell/geyser/blob/main/inst/reactlog) examples saved as `RDS` objects.
- Re-open repo to reset `reactlog` before enabling.

### Examples in the folder:

- [geyser.rds](https://github.com/byandell/geyser/blob/main/inst/reactlog/geyser.rds):
[moduleServer](https://github.com/byandell/geyser/blob/main/inst/build_module/4_moduleServer)
version of old Faithful app.
- [appPages.rds](https://github.com/byandell/geyser/blob/main/inst/reactlog/geyser.rds):
[appPages.R](https://github.com/byandell/geyser/blob/main/inst/connect_modules/appPages.R)
version of old Faithful app.
- [appDemo.rds](https://github.com/byandell/geyser/blob/main/inst/reactlog/geyser.rds):
[app.R](https://github.com/byandell/geyser/blob/main/inst/connect_modules/app.R)
Geyser Demo
(see <https://connect.doit.wisc.edu/geyserDemo>).

### Example code:

```
# Enable `reactlog` and run app.
reactlog::reactlog_enable()
shiny::runApp("inst/build_module/4_moduleServer")

# Show `reactlog` in browser.
shiny::reactlogShow()

# Save log of reactive session.
geyser_log <- shiny::reactlog()
saveRDS(geyser_log, "geyser.rds")

# Retrieve previously saved reactive session.
geyser_log <- readRDS("geyser.rds")
reactlog::reactlog_show(geyser_log)
```

