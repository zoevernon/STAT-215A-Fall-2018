library(Matching)
library(tidyverse)
data(lalonde)
head(lalonde)

# treatment indicator
z <- lalonde$treat
# observed outcome 
y <- lalonde$re78

# look at difference in outcome conditional on being in treatment or control
ggplot() + geom_histogram(aes(y[z == 0], fill = "Control"), alpha = 0.5) + 
  geom_histogram(aes(y[z == 1], fill = "Treatment"), alpha = 0.5) + 
  geom_vline(xintercept = mean(y[z == 1])) + 
  geom_vline(xintercept = mean(y[z == 0]), linetype = "dashed") + 
  theme_classic() + 
  labs(x = "Real earnings in 1978") + 
  scale_fill_discrete(name = "")

## Fisher randomization test to test difference in means
# set number of samples of random treatment assignment
num_samples <- 1000

# Store different in means between treatment and control for every sample 
dif_in_means <- sapply(1:num_samples, function(sample){
  # randomly permute the treatment assignment vector 
  z_perm <- sample(z)
  
  # compute difference in means
  mean(y[z_perm == 1]) - mean(y[z_perm == 0])
})

# observed value
dif_in_means_obs <- mean(y[z == 1]) - mean(y[z == 0])
# p-value
mean(dif_in_means >= dif_in_means_obs)

# plot histogram of sampled statistics
ggplot() + geom_histogram(aes(dif_in_means), binwidth = 200, 
                          color = "gray", size = 0.1) + 
  geom_vline(xintercept = dif_in_means_obs) + 
  theme_classic() + 
  labs(x = "Difference in means") + 
  scale_fill_discrete(name = "")

#### Neymanian inference
# ATE estimate
tau_hat <- mean(y[z == 1]) - mean(y[z == 0])

# estimate variance 
n <- length(z)
var_hat <- var(y[z == 1])/sum(z) + var(y[z == 0])/sum(n - sum(z))

# compute confidence interval (does not include 0)
c(tau_hat - 1.96*sqrt(var_hat), tau_hat + 1.96*sqrt(var_hat))

# compute p-value from normal approximation
pnorm(1 - tau_hat/sqrt(var_hat))
