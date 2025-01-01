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

def r_object(object='faithful'):
    """"
    Retrieve R object into Python.
    
    a = object_df.columns[0] gets name of first column.
    object_df[a]
    
    Parameters
    ----------
    object: character string (dataset name in R package datasets)
    
    Returns
    -------
    object_df: DataFrame
    """
    import rpy2.robjects as ro
    from rpy2.robjects import pandas2ri
    from rpy2.robjects.packages import importr, data
    
    # Activate rpy2.
    pandas2ri.activate()
    
    # Import dataset from R package datasets.
    datasets = importr('datasets')
    object_env = data(datasets).fetch(object)
    object_rdf = object_env[object]
    object_df = ro.conversion.rpy2py(object_rdf)
    
    return object_df

# r_object('faithful')
