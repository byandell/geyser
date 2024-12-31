from shiny import App, render, ui
from geyser.hist import hist_server, hist_input, hist_output, hist_ui

app_ui = ui.page_fluid(
    hist_input("geyser"),
    hist_output("geyser"),
    hist_ui("geyser")
)

def server(input, output, session):
    hist_server("geyser")

app = App(app_ui, server)

if __name__ == "__main__":
    app.run()
