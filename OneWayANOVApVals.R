# ANOVAs and p-values - Version 2
# The goal of this script is to calculate p-values via ANOVA for a large flow cytometer dataset.
# The input files (lines 17, 21) will need to be .csv format, where Input .CSV datasets, where:
#     Columns represent measurements of the same type, 
#     Rows represent measurements from the same individual (replicate measurements or average of technical replicates), 
#     Row 1, column 1 should read "Stim" (without the quotations),
#     The rest of Column 1 should indicate the name of the experimental condition,
#     The rest of Row 1 will then indicate the type of measurement (or be left blank).
# This script will generate a new .csv file containing one-way ANOVA and Tukey's HSD test p-values for each column of data.
# This output file will be placed in the working directory (line 17) and using the file name in line 69.
# In this early version of the script, it does not handle (1) empty columns or (2) #DIV/0! issues and will break when it
# encounters such issues.

rm(list=ls())

# MAKE SURE TO CHANGE THIS WORKING DIRECTORY TO MATCH WHERE YOUR DATA IS LOCATED
setwd("D:/WorkingDir")
getwd()

# MAKE SURE TO CHANGE THE DATA FILE TO INDICATE THE ACTUAL NAME OF THE FILE WITH YOUR DATA.
dataset <- read.csv("filename.csv")
head(dataset)
str(dataset)
biomarker = names(dataset)

aovtemp <- aov(lm(dataset[,2] ~ Stim, dataset))
TukeysFunction <- TukeyHSD(aovtemp, "Stim", conf.level = 0.95)
Npairwise <- length(TukeysFunction$Stim[,4]) + 5
pvalues.mat <- matrix(, nrow = Npairwise, ncol = 0)

k <- length(dataset) - 1
for (i in 1:k) {
  # This part computes the p-values of the ANOVA & Tukey's post-tests.
  j <- i + 1
  anovatest <- anova(lm(dataset[,j] ~ Stim, dataset))
  aovtemp <- aov(lm(dataset[,j] ~ Stim, dataset))
  TukeysFunction <- TukeyHSD(aovtemp, "Stim", conf.level = 0.95)
  
  # Stores the Tukey's HSD p values in a real matrix, since the TukeyHSD function is just a function.
  Tukeymatrix <- matrix(, nrow = 0, ncol = 1)
  for (m in 1:length(TukeysFunction$Stim[,4])) {
    Tukeymatrix <- rbind(Tukeymatrix, TukeysFunction$Stim[m,4])
  }
  
  # Stores the overall ANOVA p- and F-values in a matrix
  Header <- matrix(
    c(biomarker[j],anovatest[1,5],anovatest[1,4],"---","---"),
    nrow = 5,
    ncol = 1
  )
  
  ColResults <- matrix(
    rbind(Header,Tukeymatrix),
    nrow = Npairwise,
    ncol = 1
  )
  
  # Stores the column results to the overall matrix that will be written as CSV later.
  pvalues.mat <- cbind(pvalues.mat, ColResults)
}

# Adding labels so that it's easy to identify which p-values correspond to what pairwise comparison
FirstCol <- matrix(
  c("Cluster", "ANOVA p", "F-value", "---", "---", rownames(TukeysFunction$Stim)),
  nrow = Npairwise,
  ncol = 1
)
rownames(pvalues.mat) <- FirstCol
write.csv(pvalues.mat, file = "Rtemp_pValues.csv")
