# CellBio_SimpleStats
# Run simple statistical analyses on pre-formatted datasets (CSV format), downsample flow cytometry or gene expression raw data, or reference mRNA sequencing rpkm datasets to pull data corresponding to an input 'hit list'.
# 
# OneWayANOVApVals.R:
# Input .CSV datasets, where columns represent measurements of the same type, and rows represent measurements from the same individual (replicate measurements or average of technical replicates). Perform statistical tests, generating new .csv files with the p-values and f-values.
# 
# RandDownSampler.R:
# Function that reads a large dataset containing rows of potentially unrelated measurements linked to the same individual, and randomly downsamples that by a factor of X, generating a new .CSV file that contains only the downsampled events.
