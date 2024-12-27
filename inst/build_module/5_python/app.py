from shiny import App, render, ui

# run_hist.py
with open('/Users/brianyandell/Documents/Research/geyser/python/hist.py', 'r') as file:
    code = file.read()
exec(code)

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
