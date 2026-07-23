# Geyser Developer Guides & Planning Record

This document consolidates the blueprint prompts, implementation plan, and execution walkthrough for building the Developer Guide architecture in the `geyser` hybrid R/Python repository.

---

## 1. Blueprint Prompts

*Source: `../Documentation/prompts/devel_guide.md#hybrid-r--python-projects`*

### Hybrid R & Python Projects Blueprint

In research repositories (like `geyser` or `landmapyr`), R and Python code sit side-by-side. The developer guide reconciles both ecosystems, outlining boundaries and interfaces.

#### Directory Layout Pattern
```text
hybrid_project/
├── DEVELOPER.md                    # Root architecture index for both languages
├── r/                              # R package sub-project
│   ├── R/
│   └── vignettes/
├── python/                         # Python package sub-project
│   ├── pyproject.toml
│   └── docs/
└── data/                           # Shared raw / processed data artifacts
```

#### Actionable Prompts

1. **Bridge Architecture Map**:
   > "Create a root `DEVELOPER.md` describing how the R and Python components cooperate. Trace the communication boundaries (e.g., `reticulate`, `rpy2`, subprocess calls, REST APIs, or shared SQLite/Parquet files). Group files by language and function."

2. **Dual-Environment Configuration**:
   > "Create environment guides mapping out how to bootstrap both R and Python environments on a local machine. Document dependencies (e.g., a shared conda `environment.yml` or installation scripts)."

3. **Shared Data & API Schemas**:
   > "Document data structures shared between R and Python code. Define SQLite database schemas, HDF5 hierarchies, or Parquet column schemas, detailing validation checks on both sides."

#### Steps to Perform

1. **Map Cross-Language Boundary**: Determine if languages communicate at runtime (e.g., via `reticulate` in R, web sockets, or system APIs) or offline (e.g., Python pre-processes data, R Shiny visualizes it).
2. **Create Combined Root Guide**: Write a root `DEVELOPER.md` detailing directory splits, shared folder layouts, and build steps.
3. **Draft Language-Specific Sub-Guides**:
   - For R: Link to `vignettes/` developer docs.
   - For Python: Link to `docs/devel/python.md` or `geyser/README.md`.
4. **Define Dual-Testing Workflows**: Outline execution scripts that run both testing suites and standalone module launchers.
5. **Coordinate Shared Data Schemas**: Formulate explicit specifications for exchange file formats (e.g., `pandas.DataFrame` / R data frame conversion via `rpy2`).

---

## 2. Implementation Plan

*Approved Plan for `geyser` Developer Guide*

### Overview & Objectives
`geyser` is a dual-ecosystem project (R package v0.7.2 and Python package v0.2) demonstrating Shiny module patterns using the Old Faithful geyser dataset as an educational reference.

The goal is to:
1. Create a primary **`DEVELOPER.md`** file in the repository root that acts as the developer architecture entry point for both R and Python codebases.
2. Establish a clear dual-housing strategy for language-specific extensive sub-guides:
   - **R Sub-Guides**: Housed in package vignettes (`vignettes/DeveloperGuide.Rmd`).
   - **Python Sub-Guides**: Housed in `docs/devel/python.md` (for website rendering) and `geyser/README.md` (for Python package source developers).
3. Update `README.md` to reference `DEVELOPER.md`.

### Target Directory Layout

```text
geyser/
├── DEVELOPER.md                    # Root architecture index & hybrid guide (both R & Python)
├── README.md                       # Repository overview & quickstart (links to DEVELOPER.md)
├── guides.md                       # Combined record of prompts, plan, and walkthrough
├── R/                              # R package source code
├── vignettes/                      # R-centric Vignettes
│   └── DeveloperGuide.Rmd          # Master R developer guide vignette
├── geyser/                         # Python package source code
│   ├── README.md                   # Python package sub-directory developer reference
│   └── io.py, hist.py, etc.        # Python package modules
└── docs/                           # Documentation & Quarto Website
    └── devel/                      # Extended sub-guides directory
        └── python.md               # Detailed Python Developer Guide (rendered on site)
```

---

## 3. Walkthrough & Execution Record

*Completed Work Summary & Verification*

### Summary of Completed Files

1. **[`DEVELOPER.md`](DEVELOPER.md)**:
   - Root hybrid architecture guide.
   - Documents R **5-Function module pattern** (`Input`, `Output`, `UI`, `Server`, `App`) and Python **`@module.ui` / `@module.server` pattern**.
   - Side-by-side R and Python module cross-reference table.
   - Setup instructions (`devtools::load_all()` and `pip install -e .`), port discovery (`geyser.io.app_run`), and Quarto `app.py` reserved filename rules.
   - Analysis of progressive tutorial stages (`inst/build_module/`) and multi-module compositions (`inst/connect_modules/`).

2. **[`docs/devel/python.md`](docs/devel/python.md)**:
   - Extensive Python technical developer guide rendered on the Quarto site (`byandell.github.io/geyser`).
   - Explains Python Shiny reactivity, `geyser.io` helpers (`app_run` & `r_object`), Shinylive WebAssembly compilation, and `rpy2` data exchange.

3. **[`geyser/README.md`](geyser/README.md)**:
   - Sub-directory developer reference inside the Python package source folder.

4. **[`vignettes/DeveloperGuide.Rmd`](vignettes/DeveloperGuide.Rmd)**:
   - R package vignette documenting R Shiny modules for package compilation (`devtools::build_vignettes()`).

5. **[`README.md`](README.md)**:
   - Updated with direct links to Developer Guides (both published site pages and GitHub source).

6. **Website Publishing & Navbar Integration ([`_quarto.yml`](_quarto.yml) & [`publish.md`](publish.md))**:
   - Added `DEVELOPER.md`, `vignettes/DeveloperGuide.Rmd`, and `docs/devel/python.md` to Quarto render targets.
   - Added a **Developer Guides** dropdown menu to the website navbar linking to Architectural Overview, R Developer Guide, and Python Developer Guide.

### Document Reference Links

- 📘 **Architectural Overview (`DEVELOPER.md`)**: [Local File](DEVELOPER.md) | [Published Page](https://byandell.github.io/geyser/DEVELOPER.html) | [GitHub Source](https://github.com/byandell/geyser/blob/main/DEVELOPER.md)
- 📖 **R Developer Guide (`vignettes/DeveloperGuide.Rmd`)**: [Local File](vignettes/DeveloperGuide.Rmd) | [Published Page](https://byandell.github.io/geyser/vignettes/DeveloperGuide.html) | [GitHub Source](https://github.com/byandell/geyser/blob/main/vignettes/DeveloperGuide.Rmd)
- 🐍 **Python Developer Guide (`docs/devel/python.md`)**: [Local File](docs/devel/python.md) | [Published Page](https://byandell.github.io/geyser/docs/devel/python.html) | [GitHub Source](https://github.com/byandell/geyser/blob/main/docs/devel/python.md)
- 📦 **Python Package Source Reference (`geyser/README.md`)**: [Local File](geyser/README.md) | [GitHub Source](https://github.com/byandell/geyser/blob/main/geyser/README.md)
- 🏠 **Repository Landing Page (`README.md`)**: [Local File](README.md) | [Published Home](https://byandell.github.io/geyser/index.html) | [GitHub Source](https://github.com/byandell/geyser/blob/main/README.md)
- 🚀 **Publishing Guide (`publish.md`)**: [Local File](publish.md) | [GitHub Source](https://github.com/byandell/geyser/blob/main/publish.md)

