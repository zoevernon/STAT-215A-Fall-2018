library('foreach')
library('doParallel')

working.directory <- file.path("../data")                              
lingLocation <- read.delim(file.path(working.directory, 
                                     "lingLocation.txt"), 
                           header = T, sep = "")

repetitions <- 30

start.time <- Sys.time()
serial.results <- list()
for (i in 1:repetitions) {
  serial.results[[i]] <- kmeans(x = lingLocation[, 4:471], centers = 5)
}
dur1 <- Sys.time() - start.time

ncores <- 4
registerDoParallel(ncores)
start.time <- Sys.time()
parallel.results <- foreach(i = 1:repetitions) %dopar% {
  return(kmeans(x = lingLocation[, 4:471], centers = 5))
}
dur2 <- Sys.time() - start.time

print(dur1)
print(dur2)
