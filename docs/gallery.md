# Showcasing Shiny Apps and Code

This guide explains how to display both a Shiny application and its source code side-by-side or on the same page, similar to the
[Posit Shiny Gallery](https://shiny.posit.co/r/gallery/).

We cover two main approaches: using embedded client-side **Shinylive** apps in a Quarto page (highly recommended for hosting on static sites like GitHub Pages without folder clutter), and R's built-in **Showcase Mode** (best for local R console development).

---

## Method 1: Embedded Shinylive (Recommended for Web Galleries)

By using the `{shinylive-r}` Quarto block, your app code is compiled and embedded directly inside the final HTML document. This eliminates the need for any extraneous folders or files in your git repository. It also provides an interactive, copyable, and runnable editor panel side-by-side (or stacked) with the live app.

> [!TIP]
> **Customizing the Layout Components**:
>
> * **Viewer-Only Mode (Default for Galleries)**: To hide the code editor entirely and only display the running app, set `#| components: [viewer]`. This is ideal when you want to show the code in separate static tabs below the app.
> * **Interactive Code Editor**: To allow users to modify the code and run it inside their browser, set `#| components: [editor, viewer]`.

### 1. Configure the Quarto Document

Create a `.qmd` file (like [docs/demos/build_module.qmd](demos/build_module.qmd)) that includes the `shinylive` filter in the YAML header (or share it across the directory via `_metadata.yml`):

```yaml
---
title: "Build Module (Shinylive)"
filters:
  - shinylive
---
```

### 2. Embed the App using `{shinylive-r}`

Add your self-contained app code (combining your module server and main app) in a `{shinylive-r}` code chunk, specifying the `editor` and `viewer` components:

```markdown
\`\`\`{shinylive-r}
#| standalone: true
#| viewerHeight: 500
#| components: [editor, viewer]
#| layout: vertical

library(shiny)
library(bslib)

# --- Module definitions ---
geyserServer <- function(id) { ... }
geyserInput <- function(id) { ... }
geyserOutput <- function(id) { ... }
geyserUI <- function(id) { ... }

# --- App entry point ---
ui <- bslib::page(
  geyserInput(id = "geyser"), 
  geyserOutput(id = "geyser"),
  geyserUI(id = "geyser")
)
server <- function(input, output, session) {
  geyserServer(id = "geyser")
}
shiny::shinyApp(ui, server)
\`\`\`
```

### 2b. Embed Python Apps using `{shinylive-python}`

For Python-based Shiny apps, you can use the `{shinylive-python}` code block. The Quarto Shinylive filter handles compiling and packaging the Python code just like the R version.

#### 1. Specifying Requirements
Inside browser WebAssembly (Pyodide), packages are downloaded dynamically. You must declare any package requirements in your code block options:
```markdown
\`\`\`{shinylive-python}
#| standalone: true
#| viewerHeight: 600
#| components: [viewer]
#| requirements: [pandas, numpy, matplotlib, scipy]

# Python code here...
\`\`\`
```

#### 2. Multi-File Apps and Local Packages
You can structure multi-file Python applications using the same `## file: ` header comment syntax. For example, if you want to import from a local package folder (like `geyser/hist.py`), define `geyser/__init__.py` and the module files within the code block:
```markdown
## file: app.py
from shiny import App, ui
from geyser.hist import hist_server, hist_input, hist_output, hist_ui

app_ui = ui.page_fluid(
    hist_input("hist"),
    hist_output("hist"),
    hist_ui("hist")
)

def app_server(input, output, session):
    hist_server("hist")

app = App(app_ui, app_server)

## file: geyser/__init__.py
# empty package marker

## file: geyser/hist.py
# custom module logic goes here...
```

#### 3. WebAssembly Gotchas (CORS & C-Extensions)
When deploying Python Shinylive apps, be mindful of browser restrictions:
* **CORS Policies**: Standard python code that fetches data from online repositories (e.g. `seaborn.load_dataset("geyser")`) will fail due to browser CORS restriction blocks. Mock the dataset call to return a local static `pandas.DataFrame`.
* **C-Extensions**: Packages that compile C code locally (such as `rpy2` or custom DB connectors) are not compatible with standard Pyodide in the browser. You must mock those modules or replace them with native Python/browser equivalents.

### 3. Rendering and Local Preview

Modern web browsers block Service Workers and WebAssembly from running over the `file://` protocol. If you open the rendered `.html` page directly as a local file, the app will display as a blank page.

To preview and test the app locally, you must serve the files via a local HTTP server:

* **Quarto Preview (Easiest)**: Run this in your terminal. It will render the page, start a local server, and open your browser:

  ```bash
  quarto preview docs/demos/build_module.qmd
  ```

* **Python HTTP Server**: Serve the `docs/` folder from Python:

  ```bash
  python3 -m http.server 8000 --directory docs
  ```

  Then navigate to `http://localhost:8000/demos/build_module.html`.
* **R `servr` Package**: Serve from R console:

  ```r
  servr::httd("docs")
  ```

### 4. Deploying to GitHub Pages

To avoid committing large generated assets (like the 70MB `site_libs/` folder) to your Git repository, the website compilation and hosting are automated via a GitHub Actions pipeline.

For detailed setup instructions, troubleshooting steps, and custom configurations, see the [Quarto GitHub Actions Deployment Guide](github_actions.md).

> [!IMPORTANT]
> **GitHub Actions & Python Shinylive**:
> If your site includes `{shinylive-python}` blocks, the GitHub Actions deployment runner must have Python and the `shinylive` Python package installed to render them. Ensure your `.github/workflows/deploy.yml` includes:
> ```yaml
> - name: Set up Python
>   uses: actions/setup-python@v5
>   with:
>     python-version: '3.12'
> - name: Install Python dependencies
>   run: |
>     pip install shinylive
> ```
> Otherwise, the build will fail with the error: `Error running 'shinylive' command`.

Once set up, your live page will be automatically built and hosted at:
`https://byandell.github.io/geyser/demos/index.html` (or `demos/build_module.html` for the direct app).

---

## Organizing & Scaling Future Demos

As your project grows and you add more modules or demo applications, keeping them in a dedicated `docs/demos/` subdirectory scales much better than single files.

### 1. The Directory Layout
Organize the subdirectory with an index and shared metadata:
```
docs/
└── demos/
    ├── _metadata.yml          # Shared Quarto settings for the directory
    ├── index.qmd              # Demos landing/gallery index
    ├── posit_gallery.qmd      # Individual demo (e.g. iframe embed)
    ├── build_module.qmd       # Individual demo (e.g. Shinylive app)
    ├── connect_modules.qmd    # Connected modules demo (multi-file Shinylive)
    └── python_module.qmd      # Python module demo (Python Shinylive)
```

### 2. Sharing Configurations via `_metadata.yml`
Instead of repeating the `shinylive` filter and `knitr` engine in every new `.qmd` file, you can create a `_metadata.yml` file in the subdirectory. Quarto automatically applies these settings to all documents in that directory:
```yaml
# docs/demos/_metadata.yml
engine: knitr
filters:
  - shinylive
```

### 3. Automated Listing Galleries (`index.qmd`)
You can use Quarto's built-in **Listings** to automatically build a landing page grid. When you add a new demo `.qmd` file to the folder, Quarto will automatically detect it and render a preview card on the landing page, without requiring you to manually maintain list links.

Example `docs/demos/index.qmd`:
```yaml
---
title: "Geyser Demos Gallery"
toc: false
listing:
  contents:
    - build_module.qmd         # List files in the exact order you want them displayed
    - posit_gallery.qmd
  type: grid                   # Renders a modern grid layout of card previews
  categories: true             # Set to true to filter demos by tags (e.g., R, Python)
---

Explore the interactive geyser demos below:
```

### 4. Adding New Demos
To add a new demo:
1. Create a new `.qmd` file under `docs/demos/` (e.g. `gghist_demo.qmd`).
2. Add a simple YAML header specifying the title, description, and optional categories:
   ```yaml
   ---
   title: "ggplot2 Histogram Demo"
   description: "Interactive exploration of geyser wait times using ggplot2."
   categories: [R, ggplot2]
   ---
   ```
3. Use relative paths starting with `../../` to refer to root package assets (since files under `docs/demos/` are two levels deep relative to the project root).
4. Add a navigation link back to the gallery page at the top of your page content:
   ```markdown
   [← Back to Demos Gallery](index.qmd)
   ```
5. Update `index.qmd`'s `listing.contents` list if you want to explicitly place it in the display order.

---

## Method 2: Shiny Showcase Mode (Built-in R Shiny)

If you are developing or running the app locally, R's built-in **Showcase Mode** is the easiest option. It puts the app in a frame, shows the code next to/below the app, and highlights reactive execution in real-time.

### Running Showcase Mode

To launch the app in showcase mode from your R console:

```r
shiny::runApp("inst/build_module/4_moduleServer", display.mode = "showcase")
```

### Adding Metadata & Documentation

To configure the showcase:

1. Add a `DESCRIPTION` file to the app folder:

   ```dcf
   Title: Geyser Module Server App
   Author: Brian S. Yandell
   Description: Old Faithful geyser dataset module server demo.
   DisplayMode: Showcase
   ```

2. Add a `README.md` to the app folder. Shiny will automatically render this markdown file directly below the code panel.
