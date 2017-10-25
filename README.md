# CellBio_SimpleStats
Run simple statistical analyses on pre-formatted datasets (CSV format), downsample flow cytometry or gene expression raw data, 
or reference mRNA sequencing rpkm datasets to pull data corresponding to an input 'hit list'.

Input .CSV datasets, where columns represent measurements of the same type, and rows represent measurements from the same individual (replicate measurements or average of technical replicates). Perform statistical tests, generating new .csv files with the p-values and f-values.

In the early version of these code(s), the .CSV files must be formatted such that row 1, column 1 should read "Stim" (without the quotations), and the rest of column 1 should indicate the name of the experimental condition. Row 1 will then indicate the type of measurement (or be left blank).
