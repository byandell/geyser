# Helper script to load geyser package modules dynamically depending on running environment
if (dir.exists("R")) {
  for (f in list.files("R", pattern = "\\.[Rr]$", full.names = TRUE)) source(f)
} else if (dir.exists("../../R")) {
  for (f in list.files("../../R", pattern = "\\.[Rr]$", full.names = TRUE)) source(f)
} else {
  library(geyser)
}
