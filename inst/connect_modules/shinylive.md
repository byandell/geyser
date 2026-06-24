# Shinylive Export

AI successfully updated the app setup to work natively in Shinylive / WebAssembly without requiring the `geyser` package to be pre-built and downloaded from a Wasm repository.

## R commands

```r
# Export the Shinylive application
# This creates a static HTML file that can be served directly from a web server
shinylive::export(appdir = "inst/connect_modules", destdir = "docs/shiny")

# (Optional) Run the static server locally to check
httpuv::runStaticServer("docs/shiny/", port = 8008)
```

## Changes Made

### 1. Copied Package Modules to App Directory

Copied the package module R scripts from the root `R/` directory directly into the [inst/connect_modules/R/](file:///Users/brianyandell/Documents/GitHub/geyser/inst/connect_modules/R) directory so they are bundled into `docs/shiny` during `shinylive::export()`.

### 2. Created Load Helper

Created [load_geyser.R](file:///Users/brianyandell/Documents/GitHub/geyser/inst/connect_modules/load_geyser.R) in the app directory to handle loading package code dynamically depending on the execution context:

- Sourcing from `R/` (when running inside the Shinylive bundle).
- Sourcing from `../../R/` (when running app files directly from `inst/connect_modules/` during local development).
- Loading the installed package using `library(geyser)` (when deployed to a server environment like Posit Connect).

```r
# Helper script to load geyser package modules dynamically depending on running environment
if (dir.exists("R")) {
  for (f in list.files("R", pattern = "\\.[Rr]$", full.names = TRUE)) source(f)
} else if (dir.exists("../../R")) {
  for (f in list.files("../../R", pattern = "\\.[Rr]$", full.names = TRUE)) source(f)
} else {
  library(geyser)
}
```

### 3. Updated Shiny Apps to use Load Helper

Modified [inst/connect_modules/app.R](file:///Users/brianyandell/Documents/GitHub/geyser/inst/connect_modules/app.R) and other `.R` app templates to source `load_geyser.R` and removed `geyser::` prefixes from their module calls.

### 4. Ignored Local Shinylive Build Outputs

Appended `/docs/shiny/` to [.gitignore](file:///Users/brianyandell/Documents/GitHub/geyser/.gitignore) to prevent the large, locally generated Shinylive static assets from being committed to Git history.

### 5. Configured GitHub Actions CI/CD Deployment

Created [.github/workflows/deploy.yml](file:///Users/brianyandell/Documents/GitHub/geyser/.github/workflows/deploy.yml) to automatically compile the Shinylive application (placing it in the `docs/shiny/` subfolder) and publish the entire `docs/` directory (including `.html`, `.qmd` and other documentation files) directly to GitHub Pages on every push to `main` or `master`.

---

## Verification & Results

1. Ran `shinylive::export(appdir = "inst/connect_modules", destdir = "docs/shiny")` to generate the new app bundle.
2. Served the application locally using `httpuv::runStaticServer("docs/shiny/")`.
3. Verified via browser subagent that the Shinylive app loaded and rendered the histogram plot correctly in the browser without getting blocked on the package warning.
4. Added the workflow and gitignored the local build output directory to keep the repository size small and clean, while serving the entire `docs/` folder.

## What happens now?

Whenever you push to the `main` or `master` branch:

1. GitHub will spin up an environment, install `shinylive` and other setup tools.
2. It will copy the root `R/` package scripts dynamically into `inst/connect_modules/R/`.
3. It will export the Shinylive application with `wasm_packages = FALSE` directly into `docs/shiny`.
4. It will publish the entire `docs/` folder (making both your Shinylive app at `/shiny/` and your other HTML/QMD docs at `/` live) directly to your GitHub Pages hosting.

## Publishing Quarto Documents

To publish Quarto documents like `inst/connect_modules/quarto/demo.qmd` so they are hosted on GitHub Pages:

1. **Pre-render the Document**: Render the `.qmd` file to HTML locally:
   ```bash
   # Rename the project config temporarily if it blocks rendering Shiny docs inside website projects
   mv _quarto.yml _quarto.yml.tmp
   quarto render inst/connect_modules/quarto/demo.qmd
   mv _quarto.yml.tmp _quarto.yml
   ```
2. **Copy to the Docs Folder**: Copy the `.qmd` file, the rendered `.html` file, and its associated `_files` folder to the `docs/` directory:
   ```bash
   cp inst/connect_modules/quarto/demo.qmd docs/
   cp inst/connect_modules/quarto/demo.html docs/
   cp -r inst/connect_modules/quarto/demo_files docs/
   ```
3. **Commit to Git**: Commit and push these files to GitHub. The GitHub Actions workflow is set up to publish the entire `docs/` folder, so they will automatically be hosted online.

> [!NOTE]
> Because `demo.qmd` is a `server: shiny` document, it requires a running R server backend to be interactive. When served from GitHub Pages (which is a static host), the layout will display, but interactive inputs/charts won't work. For full interactivity, host it on a server like Posit Connect.

## Final Step Required by User

Please go to your repository on GitHub, navigate to **Settings** > **Pages**, and under **Build and deployment** > **Source**, make sure it is changed to **GitHub Actions** instead of "Deploy from a branch".
