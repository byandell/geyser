# `geyser` Python Package Source

This directory contains the Python package source code for `geyser` v0.2.

## Directory Structure

```text
geyser/
├── __init__.py           # Package imports and exports
├── README.md             # This reference document
├── datanames.py          # Lists dataset names with numeric columns
├── datasets.py           # Dataset selector module (@module.ui & @module.server)
├── data.py               # Interactive data table module
├── hist.py               # Base matplotlib histogram module
├── gghist.py             # Plotnine/seaborn histogram module
├── ggpoint.py            # Scatter plot module
├── io.py                 # Port discovery (app_run) and rpy2 bridge (r_object)
├── rows.py               # Row layout module container
└── switch.py             # Tab module switcher container
```

## Quick Installation & Testing

```bash
# From repository root
pip install -e .

# Test modules interactively in Python
python -c "import geyser; geyser.hist.app_hist()"
python -c "import geyser; geyser.datasets.app_datasets()"
```

For detailed Python architecture and reactivity documentation, see the [Python Developer Guide](../docs/devel/python.md) or the root [DEVELOPER.md](../DEVELOPER.md).
