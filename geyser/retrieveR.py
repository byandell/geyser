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
