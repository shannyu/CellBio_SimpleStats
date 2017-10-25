# Downsampler v.1
# The purpose of this script is to randomly downsample a large dataset that by a factor of X. It will return
# a new matrix and CSV file containing the downsampled data, which can be used for further applications. This file
# will be saved using the filename indicated in line 26.
# 
# The input .CSV file is a parameter vec for this function, and needs to be formatted such that each row contains
# measurements taken from the same individual. Each column therefore represents potentially unrelated measurements,
# but are identifiable to the individual which is named in column 1.
#
# To begin, in the console, type the following command with the file name of the CSV file containing the raw data.
# dataset <- read.csv("Insert File name here")

downsampler <- function(vec, X) {
  numIndices <- nrow(dataset)/X
  numIndices <- round(numIndices, digits = 0)
  indices <- sample(1:nrow(dataset), numIndices, replace=F)
  datasetSmall <- matrix(
    nrow = 0,
    ncol = ncol(dataset)
  )
  colnames(datasetSmall) <- colnames(dataset)
  for (i in 1:length(indices)) {
    datasetSmall <- rbind(datasetSmall, dataset[indices[i],])
  }
  rownames(datasetSmall) <- rm()
  write.csv(datasetSmall, file = "R_DownsampledData.csv")
  return(datasetSmall)
}
