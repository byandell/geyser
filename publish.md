# Publish Whole Repo via GitHub Pages

**Prompt:**
Develop a plan to have this repo published via GitHub Pages from the root (/) rather than docs/. Keep docs and demos in docs/ but consider other navigation changes needed to reveal the whole repo.

**Result:**
I have completed the setup to publish the repository via GitHub Pages from the root directory (`/`) rather than `docs/`.

### Summary of Accomplishments

1. **Root Quarto Site Configuration ([`_quarto.yml`](file:///Users/brianyandell/Documents/GitHub/geyser/_quarto.yml))**:
   - Configured site output to `_site/` and specified explicit render targets.
   - Built a comprehensive navbar revealing all sections of the repository: **Home**, **Module Guide**, **Developer Guides**, **Docs & Slides**, **Demos Gallery**, and link to **GitHub**.

2. **Root Landing Page & Clean Up**:
   - Created [`index.qmd`](file:///Users/brianyandell/Documents/GitHub/geyser/index.qmd) rendering root [`README.md`](file:///Users/brianyandell/Documents/GitHub/geyser/README.md).
   - Added [`.quartoignore`](file:///Users/brianyandell/Documents/GitHub/geyser/.quartoignore) to exclude virtualenv (`myenv/`) and non-static R Shiny server files.
   - Removed obsolete files (`_config.yml`, legacy `index.html`, `docs/_quarto.yml`).

3. **Developer Guides Publishing**:
   - Added [`DEVELOPER.md`](file:///Users/brianyandell/Documents/GitHub/geyser/DEVELOPER.md), [`vignettes/DeveloperGuide.Rmd`](file:///Users/brianyandell/Documents/GitHub/geyser/vignettes/DeveloperGuide.Rmd), and [`docs/devel/python.md`](file:///Users/brianyandell/Documents/GitHub/geyser/docs/devel/python.md) to Quarto render targets.
   - Added a **Developer Guides** dropdown menu to the website navbar linking to Architectural Overview, R Developer Guide, and Python Developer Guide.
   - Updated [`README.md`](file:///Users/brianyandell/Documents/GitHub/geyser/README.md) and [`DEVELOPER.md`](file:///Users/brianyandell/Documents/GitHub/geyser/DEVELOPER.md) with side-by-side links to both published site pages and raw GitHub source code files.

4. **CI/CD Workflow Update ([`.github/workflows/deploy.yml`](file:///Users/brianyandell/Documents/GitHub/geyser/.github/workflows/deploy.yml))**:
   - Updated GitHub Actions to install Shinylive at root level, render `quarto render .`, create `.nojekyll`, and upload `_site` as the deployment artifact.

5. **Verification**:
   - Fixed `knitr::opts_chunk$set` syntax in `vignettes/DeveloperGuide.Rmd`.
   - Successfully rendered the entire site locally using `quarto render .`. All 14 pages compiled cleanly into `_site/`.

