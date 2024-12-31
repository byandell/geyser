def app_run(app):
    """Run app finding free port."""
    import socket
    import webbrowser

    def find_free_port():
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            s.bind(('', 0))
            return s.getsockname()[1]

    free_port = find_free_port()
    url = f"http://127.0.0.1:{free_port}"
    print(f"Running on {url}")
    
    # Open the app in the default web browser
    webbrowser.open(url)
    print(f"Running on port: {free_port}")
    app.run(host="127.0.0.1", port=free_port)

    return None

# app_port_run(app)

def retrieveR(object='faithful'):
    """"Retrieve R object into Python."""
    import pandas as pd
    from rpy2 import robjects
    from rpy2.robjects import pandas2ri
    from rpy2.robjects.conversion import localconverter

    # `faithful$eruptions` from R
    pandas2ri.activate()

    # Retrieve the R data frame
    faithful = robjects.r[object]
    # Use localconverter to handle the conversion
    with localconverter(robjects.default_converter + pandas2ri.converter):
        faithful_df = robjects.conversion.rpy2py(faithful)
        
    return faithful_df
  
# retrieveR('faithful')

