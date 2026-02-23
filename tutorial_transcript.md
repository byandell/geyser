# R Shiny Club - Meeting Recording

**Date:** December 11, 2024
**Duration:** 1h 17m 59s
**Host:** Victor M. Ruotti
**Speaker:** Brian Yandell

---

This is a transcript of a
[presentation I gave to the R Shiny Club on December 11, 2024.](https://drive.google.com/file/d/1BGSIhihpBc-2TfRza5RGeXBCB55EC6-l).

## Table of Contents

1. [Introduction: Old Faithful Geyser Example [12:30]](#introduction-old-faithful-geyser-example-1230)
2. [Basic Shiny App Structure (UI and Server) [13:30]](#basic-shiny-app-structure-ui-and-server-1330)
3. [Server Logic and Input/Output Parameters [15:28]](#server-logic-and-inputoutput-parameters-1528)
4. [Modularizing Shiny Code [17:54]](#modularizing-shiny-code-1754)
5. [Advanced UI Components and Dynamic Output [22:00]](#advanced-ui-components-and-dynamic-output-2200)
6. [Running Shiny Apps as Functions [24:00]](#running-shiny-apps-as-functions-2400)
7. [Understanding Reactivity and the React Log [29:30]](#understanding-reactivity-and-the-react-log-2930)
8. [Demonstrating the React Log in Action [31:50]](#demonstrating-the-react-log-in-action-3150)
9. [Working with Multiple Modules [37:25]](#working-with-multiple-modules-3725)
10. [Laying Out Apps with Rows and Columns [40:12]](#laying-out-apps-with-rows-and-columns-4012)
11. [Nested Modules and Data Communication [47:35]](#nested-modules-and-data-communication-4735)
12. [Complex Reactivity Demo [51:20]](#complex-reactivity-demo-5120)
13. [Managing Module Identifiers and Namespaces [55:22]](#managing-module-identifiers-and-namespaces-5522)
14. [Best Practices for Shiny Module Design [1:02:15]](#best-practices-for-shiny-module-design-10215)
15. [Applications of Shiny for Analysis and Debugging [1:05:18]](#applications-of-shiny-for-analysis-and-debugging-10518)
16. [Quarto Integration and Language Convergence [1:08:55]](#quarto-integration-and-language-convergence-10855)

---

## Introduction: Old Faithful Geyser Example [12:30]

Whenever you start looking at Shiny modules, the first thing you'll encounter is this example: the Old Faithful geyser at Yellowstone. I visited it on my drive out there. I waited and waited, and then it went up—about 50 feet or so. People started running to their cars, and I started running too, before I realized: "Why am I doing that? I'm not on a schedule." So I just ended up walking around.

They recorded the length of the eruption and the waiting time between eruptions. (Azzalini, A. and Bowman, A. W. (1990). *A look at some data on the Old Faithful geyser*. Applied Statistics, 39, 357–365. [doi:10.2307/2347385](https://doi.org/10.2307/2347385).) I'm going to take this example and examine it in detail.

## Basic Shiny App Structure (UI and Server) [13:30]

First, looking at the code itself
([Old Faithful Shiny App](https://shiny.posit.co/gallery/old-faithful/)).
In the app, you can change the bandwidth, add a density curve, and adjust its smoothness. There's also a little rug plot showing the observations.

I took that example and organized it into a module. One way to set up an app is to have a single file (`app.R`) with two main objects defined in it:

1. **UI**: An object that defines the user interface.
2. **Server**: A function containing the logic.

You put these together into a Shiny app: `shinyApp(ui, server)`. The UI sets up the user interface, and the server provides the logic.

- [Old Faithful Shiny App](https://shiny.posit.co/gallery/old-faithful/)
- [Original Old Faithful Code](https://connect.doit.wisc.edu/geyserShinyModules/slideDeck.html#/original-old-faithful-code)

## Server Logic and Input/Output Parameters [15:28]

Looking at the interface, there are elements for input: the number of histogram breaks, whether to show individual observations (the rug plot), and whether to show the density. If you enable the density, you can then adjust the bandwidth via a conditional slider.

The other half is the server logic. The server calls the standard R `hist()` function with various arguments. One argument is the number of breaks, which is tied to the input. You can also set the bandwidth adjustment parameter, determined by the slider input at the bottom.

- [Old Faithful App Code](inst/build_module/1_oldfaithful/app.R)
- [Faithful Server Logic](inst/build_module/1_oldfaithful/appLogic.R)
- [Faithful Code with Server Logic](https://connect.doit.wisc.edu/geyserShinyModules/slideDeck.html#/faithful-code-with-server-logic)

## Modularizing Shiny Code [17:54]

We can take that code and turn it into a module by taking chunks of code and putting them into functions. I've defined four functions: three for the UI (input, output, and UI layout) and one for the server logic. They all share the same identifier.

Instead of having a half-page of server logic, I now have a single line in the main server function. These pieces then go into the Shiny app.

The `app.R` file now looks very clean. The actual modularized source code is in a separate file where those functions are defined. For example, the input function contains the three input components.

- [Modular App](inst/build_module/4_moduleServer/app.R)
- [Modular Geyser App](https://connect.doit.wisc.edu/geyserShinyModules/slideDeck.html#/modular-geyser-app)

## Advanced UI Components and Dynamic Output [22:00]

The slider input can have some complicated logic. I use a Shiny function called `uiOutput()`, and its "meat" is actually defined in the server using `renderUI()`.

I often use the convention of putting the package name in front (e.g., `shiny::sliderInput()`) to be explicit. You can use any R functions in here, like `hist()` from the `graphics` package or `ggplot2` functions. I make package names explicit to be clear which package a function belongs to.

- [Module Server](inst/build_module/4_moduleServer/moduleServer.R)
- [Self Contained GeyserApp Function](https://connect.doit.wisc.edu/geyserShinyModules/slideDeck.html#/self-contained-geyserapp-function)
- [Shiny Module in One File](https://connect.doit.wisc.edu/geyserShinyModules/slideDeck.html#/shiny-module-in-one-file)

## Running Shiny Apps as Functions [24:00]

Typically, when you deploy an app, you set it up in a folder with a file called `app.R`. However, you can also test modules independently by wrapping them in a function (e.g., `geyserApp()`). This function is a complete app in itself.

In RStudio, you can run this function to test a specific module. The advantage of this approach, especially as you build more complicated examples, is that you can test each module independently. This is a convention suggested in the Posit Shiny module documentation. It's much nicer for testing things out.

## Understanding Reactivity and the React Log [29:30]

Reactivity is the core of Shiny. Anytime you click something, you're changing the state of the app, and it reacts by updating the outputs. It's much more efficient than old asynchronous JavaScript (AJAX) approaches because it reflects the current state of inputs and outputs.

Shiny uses two main objects: `input` (containing elements with special properties) and `output` (like histograms or tables). The server is efficiently "listening" for inputs—it doesn't poll constantly but waits for a signal from the browser to initiate an action and send a signal back.

## Demonstrating the React Log in Action [31:50]

The `reactlog` package is a powerful tool for monitoring this activity. It logs every action in a session, creating a directed graph of dependencies. If you change a parameter (like the number of breaks), it "invalidates" anything downstream from that input.

When a node is invalidated (turning from green to grey in the log), any plot or output that depends on it must be recalculated. This ensures that the app only does the work it needs to do. You can subset the React log to focus on specific parts of your logic. It's worth reading the "Shiny React Log" article for a deeper dive.

- [Shiny React Log](https://shiny.posit.co/articles/reactlog.html)
- [Reactlog Show App Reactivity](https://connect.doit.wisc.edu/geyserShinyModules/slideDeck.html#/reactlog-show-app-reactivity)

## Working with Multiple Modules [37:25]

Now, let's look at using multiple modules. I created a version with a navigation bar containing three instances: a standard histogram (`hist`), a `ggplot2` histogram (`gg_hist`), and a scatter plot (`gg_point`).

Each tab panel calls a module. The first two are histograms, while the third is a scatter plot requiring two variables (like eruption duration against waiting time). The logic for creating these is straightforward once you have the module functions defined.

- [Connecting Modules Across Pages](https://connect.doit.wisc.edu/geyserShinyModules/slideDeck.html#/connecting-modules-across-pages)

## Laying Out Apps with Rows and Columns [40:12]

We can also put these modules on the same page using a grid layout. A `fluidRow()` is divided into 12 units using the `column()` function. For example, you can have two columns of 6 or three columns of 4.

I set up an example where you can pick different datasets (like `faithful` or `mtcars`). The controls for each module work separately. You can change the data or variables on the fly, and the app updates accordingly.

- [Connecting Modules Rows and Columns](https://connect.doit.wisc.edu/geyserShinyModules/slideDeck.html#/connecting-modules-rows-and-columns)

## Nested Modules and Data Communication [47:35]

As apps get more complex, you can have modules that call other modules. For example, a "row module" can contain a "data module" and several "plot modules." The output from the data module (the selected dataset) becomes the input for the plot modules.

This allows for very sophisticated architectures where five or more "servers" (module instances) are communicating. The term "module" in Shiny has its own specific meaning, distinct from how it might be used in other contexts, but it's been the standard in Shiny for ten years.

- [Connecting Modules with Plot Switch](https://connect.doit.wisc.edu/geyserShinyModules/slideDeck.html#/connecting-modules-with-plot-switch)

## Complex Reactivity Demo [51:20]

I demonstrated this with the React log enabled. Changing the dataset in the "data module" updates the available variables, which in turn invalidates the plots. You can trace the dependency from the data selection through to the final `ggplot` output in the React log.

Having each module have its own test function makes debugging these complex interactions much easier.

## Managing Module Identifiers and Namespaces [55:22]

A critical part of Shiny modules is the identifier (the `id` or `namespace`). If you use the same identifier for two different instances of a module, they will get confused—one might control the other's output.

In my code, I explicitly assign identifiers like `hist_1` and `hist_2`. This ensures that their inputs and outputs stay isolated even if they use the same underlying module code. If you flip the identifiers between the UI and the server, you can even intentionally swap their outputs, which is a good way to test your understanding of how they are tied together.

- [Goofing Around with Duplicate Modules](https://connect.doit.wisc.edu/geyserShinyModules/slideDeck.html#/goofing-around-with-duplicate-modules)

## Best Practices for Shiny Module Design [1:02:15]

When building complicated apps, start with individual components. My rule of thumb is to keep modules small—ideally with no more than three UI components (input, output, and maybe a UI layout).

Stick to consistent naming conventions (like `input`, `output`, `ui`). If you find yourself needing more than three major components in one module, it's often a sign that you should break it down into multiple modules. For example, I have modules dedicated solely to gathering parameters, which are then passed to other modules for plotting or downloading data. "Think small" and "Don't Repeat Yourself" (DRY) are key principles.

## Applications of Shiny for Analysis and Debugging [1:05:18]

I use Shiny not just for presenting data to others, but also for my own exploratory data analysis and debugging. Instead of constantly editing lines in an R Markdown file and re-running them, I'll write a small Shiny app to test different situations or arguments on the fly. It might take 50 lines of code, but it's a worthwhile investment. It helps you move away from traditional, linear R scripts and toward a more modular, interactive workflow.

## Quarto Integration and Language Convergence [1:08:55]

You can also integrate Shiny with Quarto to create interactive dashboards. Quarto allows you to connect Shiny apps written in R and Python. While I primarily use R, there is a growing convergence between languages.

For example, Python has the `shiny` package, `streamlit`, and `plotnine` (which is a Python implementation of `ggplot2`). Whether you're using R or Python, the principles of modular dashboarding and interactive data visualization are becoming increasingly similar across the data science landscape.

- [Quarto Examples](https://connect.doit.wisc.edu/geyserShinyModules/slideDeck.html#/quarto-examples)
- [Quarto Slide Deck](inst/slideDeck/slideDeck.qmd)

Original material is on Google Drive in the folder
[Diet_Systems_Genetics/Presentations](https://drive.google.com/drive/u/1/folders/1lxNJxVycKvbugTWEl5NHDO3fgTYT0AWM).
