# Run k-means on lingLocation data in parallel 
# load libraries
library('foreach')
library('doParallel')

# load data
working.directory <- file.path("../data")                              
lingLocation <- read.delim(file.path(working.directory, 
                                     "lingLocation.txt"), 
                           header = T, sep = "")

# set number of repitions for k-means
repetitions <- 30

# Run kmeans 30 times in serial (i.e. for loop of apply function)


# Run kmeans 30 times in parallel
# set number of cores
ncores <- 4
registerDoParallel(ncores)

# do computation

