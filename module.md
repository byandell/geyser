# Shiny Geyser App with and without Modules

This repo is a study in how to build Shiny apps with and without modules
using readily available data on the Old Faithful geyser.
See
[Shiny Apps](https://github.com/AttieLab-Systems-Genetics/Documentation/blob/main/ShinyApps.md)
for other Shiny apps under collaborative development.

## Table of Contents

- [Slide Decks, Demos, and Presentations](#slide-decks-demos-and-presentations)
- [R Shiny App Code Tutorial](#r-shiny-app-code-tutorial)
- [Python Modules](#python-modules)
- [References](#references)

## Slide Decks, Demos, and Presentations

Slide decks were developed using
[Quarto](https://quarto.org/);
see code in
[inst/slideDeck](https://github.com/byandell/geyser/tree/main/inst/slideDeck).

- <https://connect.doit.wisc.edu/geyserShinyModules>
- <https://connect.doit.wisc.edu/slidesPythonModules>

Demos are available at

- <https://connect.doit.wisc.edu/geyserDemo> (see
[inst/connect_modules/app.R](https://github.com/byandell/geyser/blob/main/inst/connect_modules/app.R))
- <https://connect.doit.wisc.edu/geyserQuartoDemo> (this is broken; see
[inst/connect_modules/quarto/demo.qmd](https://github.com/byandell/geyser/blob/main/inst/connect_modules/quarto/demo.qmd))

The following presentation demonstrates R Shiny apps and their modules
using the Old Faithful geyser data.

- [11 Dec 2024 Presentation](tutorial_transcript.md)

## R Shiny App Code Tutorial

Go into one of the first four folders in
[inst/build_module](https://github.com/byandell/geyser/tree/main/inst/build_module)
and run the `app.R` file using `shiny::runApp()`.
To run the `quarto` versions, you will need to install
[Quarto](https://quarto.org/) and some packages; perhaps, see
[my quarto notes](https://github.com/byandell/quarto).
You can learn something about connecting multiple modules from examples in
[inst/connect_modules](https://github.com/byandell/geyser/tree/main/inst/connect_modules).

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

### Study in [Connecting Multiple Modules](https://github.com/byandell/geyser/tree/main/inst/connect_modules)

We can connect multiple modules to develop more complicated dashboards.
Again, care with namespaces is important.
This both leads to
[DRY](https://www.getdbt.com/blog/guide-to-dry)
code and increases readability, clarifying logic and pointing to ways to improve
(or remedy broken) code.

## Python Modules

I am at an early stage with python shiny modules.
There are parts of a package here in the `geyser` folder.
Shiny python is a bit different from Shiny R in a number of ways.
See references as well as my notes below.
[Note: python files in `inst/connect_modules` have been moved to
[inst/connect_modules/python](https://github.com/byandell/geyser/tree/main/inst/connect_modules/python).]

- [slidesPythonModules](https://connect.doit.wisc.edu/slidesPythonModules)
- Simple shiny app: compare
[R](https://github.com/byandell/geyser/tree/main/inst/build_module/1_oldFaithful/appLogic.R)
to
[Python](https://github.com/byandell/geyser/tree/main/inst/build_module/5_Python/appHist.py)
- Shiny module app
  - app calling module: compare
[R](https://github.com/byandell/geyser/blob/main/inst/build_module/4_moduleServer/app_hist.R)
to
[Python](https://github.com/byandell/geyser/blob/main/inst/build_module/5_python/app_hist.py)
  - code module: compare
[R](https://github.com/byandell/geyser/blob/main/R/histApp.R)
to
[Python](https://github.com/byandell/geyser/blob/main/geyser/hist.py)

A variety of Python apps can be found in
[build_module/5_python](https://github.com/byandell/geyser/blob/main/inst/build_module/5_python)
and
[connect_modules](https://github.com/byandell/geyser/blob/main/inst/connect_modules).
Compare the `app*.R* and app_*.py` code.

While you can generally run `shiny run my_app.R` or
`shiny run my_app.py` from the system command line,
it sometimes acts wierdly for `app.py` or `app.R` files.

### Issues with Python

Be sure you have the latest Python (say 3.12),
and that you have installed
[shiny](https://pypi.org/project/shiny/)
and
[shinywidgets](https://pypi.org/project/shinywidgets/).
You will have to do install the `geyser` Python repo.
The following is supposed to work, but I have not been able to try it yet.

```
python -m pip install pip@git+https://github.com/byandell/geyser
```

Otherwise you should download the repo to your machine to install by, say

```
python -m pip install ~/Documents/GitHub/geyser
```

The Python library code is in folder
[github.com/byandell/geyser/geyser](https://github.com/byandell/geyser/blob/main/geyser)
with setup file
[github.com/byandell/setup.py](https://github.com/byandell/geyser/blob/main/setup.py)
in the main package folder.
This way, the same repo is used for both R and Python code,
and Python `import` lines refer to `geyser`.

- The file `app.py` has a confusing role.
Such a file can be run directly to deploy an app locally.
However, Quarto Python apps (see below) reserve this name.
- Issues arise quickly when trying several apps within a session,
especially if done using `reticulate` from within `Rstudio`.
- You can use other names than `app.py`, such as `app_hist.py`,
but you may have to deploy an app in a different way.
- Python shiny modules appear to work similarly to R shiny modules.
See examples above as well as the more complicated (6-module) `app_demo`:
  - [inst/compare_modules/app.R](https://github.com/byandell/geyser/blob/main/inst/connect_modules/app.R)
  - [inst/compare_modules/app_demo.py](https://github.com/byandell/geyser/blob/main/inst/connect_modules/app_demo.py)

- Python apps from Rstudio:
  - I created a Python function in the `io` module,
[r_object()](https://github.com/byandell/geyser/blob/main/geyser/io.py)
which finds a free port.
  - Some files have commented first lines to use
[reticulate](https://rstudio.github.io/reticulate/)
package to run.

### Python and Quarto and Shiny

- It is possible to combine R and Python with Quarto:
  - [inst/connect_modules/R_Python.qmd](https://github.com/byandell/geyser/blob/inst/connect_modules/R_Python.qmd)
- Often best to have `Quarto` and Python shiny apps in different folders.
- Be aware that the file `app.py` is reserved by Quarto when deploying
Python Quarto apps from any folder.
- I could not get shiny Python modules to function fully with their
server function in Quarto. Further, I could not find any working example.
Essentially, all I could do was wrap the `app*.py` code in a `python` chunk
Thus, I see no way at this time to build complicated Python-based apps
via Quarto that take advantage of Quarto's layout features,
in a way that was readily done with R-based apps.
[Note: quarto files in `inst/connect_modules` have been moved to
[inst/connect_modules/quarto](https://github.com/byandell/geyser/tree/main/inst/connect_modules/quarto).]
See for example
  - [inst/build_module/5_python/hist.qmd](https://github.com/byandell/geyser/blob/main/inst/build_module/5_python/hist.qmd)
  - [inst/connect_modules/quarto/python_demo.qmd](https://github.com/byandell/geyser/blob/main/inst/connect_modules/quarto/python_demo.qmd)

### More Python examples

- [inst/build_module/5_python/app.py](https://github.com/byandell/geyser/blob/main/inst/build_module/5_python/app.py)
functioning python app without `hist` module (open and run app)
- [inst/build_module/5_python/appHist.py](https://github.com/byandell/geyser/blob/main/inst/build_module/5_python/appHist.py)
functioning python `hist` app with module
- [inst/build_module/5_python/appGghist.py](https://github.com/byandell/geyser/blob/main/inst/build_module/5_python/appGghist.py)
module with grammar of graphics using `gghist` module
- [inst/build_module/5_python/app_gghist.py](https://github.com/byandell/geyser/blob/main/inst/build_module/5_python/app_gghist.py)
functioning python app with grammar of graphics code
- [python/penguins_restart.qmd](https://github.com/byandell/geyser/blob/main/python/penguins_restart.qmd)
working Quarto example with python
- [python/hist.py](https://github.com/byandell/geyser/blob/main/python/hist.py)
`histogram` module
- [python/gghist.py](https://github.com/byandell/geyser/blob/main/python/gghist.py)
`geom_hist` module
- [python/io.py](https://github.com/byandell/geyser/blob/main/python/io.py)
io kludges to retrieve R data `retrieveR()` and find open port and display on web brower `app_run()`

## References

- Shiny R
  - [Mastering Shiny 19: Shiny modules](https://mastering-shiny.org/scaling-modules.html)
  - [Modularizing Shiny app code](https://shiny.rstudio.com/articles/modules.html)
  - [My early experiments on shiny modules](https://github.com/byandell/shiny_module)
- Shiny Python
  - [Python Shiny Modules](https://shiny.posit.co/py/docs/modules.html)
  - [Comparison of Shiny for Python and R](https://shiny.posit.co/py/docs/comp-r-shiny.html)
  - [Shiny for Python 0.6.0](https://shiny.posit.co/blog/posts/shiny-python-0.6.0/)
  - [Shiny for Python Cheatsheet](https://rstudio.github.io/cheatsheets/html/shiny-python.html)
  - [Intro to Shiny for Python by Ryan Johnson, Posit](https://it.wisc.edu/wp-content/uploads/Intro-to-Shiny-for-Python.pdf)
([Video](https://mediaspace.wisc.edu/media/Shiny+App+with+Python+-+Posit+Day+2/1_q6p65pfh))
  - [R Interface to Python: reticulate](https://rstudio.github.io/reticulate/)
  - [Python Interface to R: rpy2](https://rpy2.github.io/)
  - [Deploying a Shiny for Python application with Posit Connect](https://posit.co/blog/deploying-a-shiny-for-python-application-with-posit-connect/)
  - [Carpentries: Interactive Data Visualizations in Python (Streamlit)](https://carpentries-incubator.github.io/python-interactive-data-visualizations/)
  - [Carpentries: Interactive Applications in Python (Shiny)](https://wvuhpc.github.io/Interactive-Applications-Python/)
  