# Shiny Server for Selected Python Datasets
import seaborn as sns
from shiny import reactive, module, render, ui, App
import geyser.io as io

@module.server
def datasets_server(input, output, session):
    """Datasets Server."""

    @reactive.effect
    def _():
        """Put selected in order chosen; reset if new dataset."""
        data = sns.load_dataset(input.dataset())
        my_choices = data.columns.to_list()
        dt = (data.dtypes.values != 'object')
        my_choices = [x for x, y in zip(my_choices, dt) if y]
        choices = my_choices
        selected = []
        for item in input.columns():
            if item in my_choices:
                selected.append(item)
        if not selected is None:
            choices = list(selected)
            for item in my_choices:
                if item not in selected:
                    choices.append(item)
        return ui.update_select("columns", choices = choices, selected = selected)
        
#    @reactive.event(input.dataset)
#    def _():
#        """Reset choices for new dataset."""
#        data = sns.load_dataset(input.dataset())
#        choices = data.columns.to_list()
#        selected = None
#        return ui.update_select("columns", choices = choices, selected = selected)
        
    @reactive.calc
    def dataset():
        data = sns.load_dataset(input.dataset())
        return data[list(input.columns())]
    
    @render.text
    def datalist():
#        selected = list(input.columns())
#        return selected
        data = sns.load_dataset(input.dataset())
        my_choices = data.columns.to_list()
        choices = my_choices
        selected = []
        for item in input.columns():
            if item in my_choices:
                selected.append(item)
        if not selected is None:
            choices = list(selected)
            for item in my_choices:
                if item not in selected:
                    choices.append(item)
        return selected, choices
    @render.data_frame
    def datatbl():
        height = 350
        width = "fit-content"
        return render.DataTable(dataset(), width=width, height=height)
        
    @render.ui
    def output_columns():
        data = sns.load_dataset(input.dataset())
        my_choices = data.columns.to_list()
        dt = (data.dtypes.values != 'object')
        choices = [x for x, y in zip(my_choices, dt) if y]
        return ui.input_select("columns", "Variables:", choices = choices, selected = None, multiple = True)
    
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
#    return ui.output_text("datalist")
    return ui.output_data_frame("datatbl")

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
