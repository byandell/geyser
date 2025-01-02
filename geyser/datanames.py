import seaborn as sns

def datanames():
    # Find probable data names in package `datasets`.
    # Put `geyser` at front.
    my_list = ['geyser'] + sns.get_dataset_names()
    dataname = []
    for item in my_list:
        if item not in dataname:
            dataname.append(item)
    
    return dataname
  
# datanames()
