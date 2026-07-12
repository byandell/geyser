# Showcasing Shiny Apps and Code

This guide explains how to display both a Shiny application and its source code side-by-side or on the same page, similar to the [Posit Shiny Gallery](https://shiny.posit.co/r/gallery/).

We cover two main approaches: using embedded client-side **Shinylive** apps in a Quarto page (highly recommended for hosting on static sites like GitHub Pages without folder clutter), and R's built-in **Showcase Mode** (best for local R console development).

---

## Method 1: Embedded Shinylive (Recommended for Web Galleries)

By using the `{shinylive-r}` Quarto block, your app code is compiled and embedded directly inside the final HTML document. This eliminates the need for any extraneous folders or files in your git repository. It also provides an interactive, copyable, and runnable editor panel side-by-side (or stacked) with the live app.

### 1. Configure the Quarto Document
Create a `.qmd` file (like [docs/demo_gallery.qmd](file:///Users/brianyandell/Documents/GitHub/geyser/docs/demo_gallery.qmd)) that includes the `shinylive` filter in the YAML header:

```yaml
---
title: "Geyser Module Server Gallery Demo"
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

### 3. Rendering and Local Preview
Modern web browsers block Service Workers and WebAssembly from running over the `file://` protocol. If you open the rendered `.html` page directly as a local file, the app will display as a blank page.

To preview and test the app locally, you must serve the files via a local HTTP server:

* **Quarto Preview (Easiest)**: Run this in your terminal. It will render the page, start a local server, and open your browser:
  ```bash
  quarto preview docs/demo_gallery.qmd
  ```
* **Python HTTP Server**: Serve the `docs/` folder from Python:
  ```bash
  python3 -m http.server 8000 --directory docs
  ```
  Then navigate to `http://localhost:8000/demo_gallery.html`.
* **R `servr` Package**: Serve from R console:
  ```r
  servr::httd("docs")
  ```

### 4. Deploying to GitHub Pages
To avoid committing large generated assets (like the 70MB `site_libs/` folder) to your Git repository, the website compilation and hosting are automated via a GitHub Actions pipeline.

For detailed setup instructions, troubleshooting steps, and custom configurations, see the [Quarto GitHub Actions Deployment Guide](github_actions.md).

Once set up, your live page will be automatically built and hosted at:
`https://byandell.github.io/geyser/demo_gallery.html`

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
