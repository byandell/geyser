from shiny import App, render, ui
from geyser.hist import hist_server, hist_input, hist_output, hist_ui

app_ui = ui.page_fluid(
    hist_input("hist"),
    hist_output("hist"),
    hist_ui("hist")
)

def server(input, output, session):
    hist_server("hist")

app = App(app_ui, server)

if __name__ == "__main__":
    app.run()
