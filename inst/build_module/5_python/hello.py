import shiny
from shiny import ui, reactive, render, module, App
import geyser.io as io

# Create the default reactive expression
def create_default_reactive_greeting(input):
    @reactive.calc
    def default_greeting():
        return f"Hello, {input.name()}!"
    return default_greeting

# Define the server logic with reactive_greeting as a parameter with a default reactive value
@module.server
def hello_server(input, output, session, reactive_greeting=None):
    if reactive_greeting is None:
        reactive_greeting = create_default_reactive_greeting(input)
    
    @render.text
    def greeting():
      return reactive_greeting()
    
    return None
    
@module.ui
def hello_input():
    return ui.input_text("name", "Enter your name:", "")
@module.ui
def hello_output():
    return ui.output_text("greeting")

def hello_app():
    """hello App."""
    app_ui = ui.page_fluid(
        hello_input("hello"),
        hello_output("hello")
    )
    def app_server(input, output, session):
        hello_server("hello", greet)
    
    @reactive.Calc
    def greet():
        return "Goodbye"

    app = App(app_ui, app_server)

    #if __name__ == '__main__':
    io.app_run(app)

# hello_app()
