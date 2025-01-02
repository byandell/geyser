# Shiny Server for Selected Python Datasets
import seaborn as sns
from shiny import reactive, module, render, ui, App
import geyser.io as io

@module.server
def datasets_server(input, output, session):
    """Datasets Server."""

    @reactive.event(input.dataset)
    def update_columns():
        choices <- input.columns()
        return ui.update_select("columns", choices = choices, selected = None)

    @reactive.calc
    def dataset():
        data = sns.load_dataset(input.dataset())
        return data[list(input.columns())]
    
    # *** this is not working.
    @render.data_frame
    def datatbl():
        height = 350
        width = "fit-content"
        return render.DataTable(dataset(), width=width, height=height)
        
    @render.ui
    def output_columns():
        data = sns.load_dataset(input.dataset())
        my_choices = data.columns.to_list()
        choices = my_choices
        selected = None
        # Code not working to get unique order as selected.
        if not selected is None:
            choices = [x for x in my_choices if x not in selected]
        return ui.input_select("columns", "Variables:", choices = choices, selected = selected, multiple = True)
    
    return dataset

@module.ui
def datasets_input():
    from geyser.datanames import datanames
    return ui.input_select("dataset", "Dataset:", datanames())

@module.ui
def datasets_ui():
    return ui.output_ui("output_columns")

@module.ui
def datasets_output():
  return ui.output_text("datatbl")

def datasets_app():
  app_ui = ui.page_fluid(
      datasets_input("datasets"), 
      datasets_ui("datasets"), 
      datasets_output("datasets")
  )
  def app_server(input, output, session):
      datasets_server("datasets")

  app = App(app_ui, app_server)
  io.app_run(app)
