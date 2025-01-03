import seaborn as sns

def datanames():
    # Find probable data names in package `datasets`.
    # Put `geyser` at front.
    my_list = ['geyser'] + sns.get_dataset_names()
    dataname = []
    for item in my_list:
        if item not in dataname:
            # Check if at least one column is not `object`.
            data = sns.load_dataset(item)
            dt = (data.dtypes.values != 'object')
            if sum(dt) > 1:
                dataname.append(item)
    
    return dataname
  
# datanames()
