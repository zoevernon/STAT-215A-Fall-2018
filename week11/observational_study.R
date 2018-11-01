# Script for comparing randomized experiment to an observational study using
# Note some of this code is based on Peng Ding's code for 239A
# functions for estimating the effects
library(Matching)
ObsCausal.est = function(z, y, x, out.family = gaussian, 
                         truncpscore = c(0, 1), K,
                         quad_out = FALSE, quad_prop = FALSE)
{
  ## fitted propensity score
  if(quad_prop == TRUE){
    pscore   = glm(z ~ x + x^2, family = binomial)$fitted.values
    pscore   = pmax(truncpscore[1], pmin(truncpscore[2], pscore))
  }else{
    pscore   = glm(z ~ x, family = binomial)$fitted.values
    pscore   = pmax(truncpscore[1], pmin(truncpscore[2], pscore))
  }
  
  
  ## fitted potential outcomes
  if(quad_out == TRUE){
    outcome1 = glm(y ~ x + x^2, weights = z, family = out.family)$fitted.values
    outcome0 = glm(y ~ x + x^2, weights = (1 - z), family = out.family)$fitted.values
  }else{
    outcome1 = glm(y ~ x, weights = z, family = out.family)$fitted.values
    outcome0 = glm(y ~ x, weights = (1 - z), family = out.family)$fitted.values
  }
  
  
  ## regression imputation estimator
  ace.reg  = mean(outcome1 - outcome0) 
  ## propensity score weighting estimator
  ace.ipw0 = mean(z*y/pscore - (1 - z)*y/(1 - pscore))
  ace.ipw  = mean(z*y/pscore)/mean(z/pscore) - 
    mean((1 - z)*y/(1 - pscore))/mean((1 - z)/(1 - pscore))
  
  ## doubly robust estimator
  res1     = y - outcome1
  res0     = y - outcome0
  ace.dr   = ace.reg + mean(z*res1/pscore - (1 - z)*res0/(1 - pscore))
  
  ## stratified propensity score
  # compute quantiles 
  quants <- quantile(pscore, probs = seq(1/K, 1 - 1/K, by = 1/K))
  # split into K groups 
  pscore_strat <- cut(pscore, 
                      breaks = c(-Inf, quants, Inf), 
                      labels = as.character(1:K))
  
  
  # compute
  blevels = unique(pscore_strat)
  K = length(blevels)
  PiK     = rep(0, K)
  TauK_unadj    = rep(0, K)
  TauK_adj    = rep(0, K)
  dif_means <- matrix(rep(0, K*dim(x)[2]), nrow = dim(x)[2])
  for(k in 1:K){
    bk         = blevels[k]
    zk         = z[pscore_strat == bk]
    yk         = y[pscore_strat == bk]
    xk         = x[pscore_strat == bk, ]
    PiK[k]     = length(zk)/length(z)
    
    # drop groups that don't have any people in either treatment or control
    if(length(zk[zk == 1]) == 0 | length(zk[zk == 0]) == 0){
      TauK_unadj[k] = 0
      TauK_adj[k] = 0
      
      # set mean of the groups to 0 (signifies being dropped)
      dif_means[ , k] <- 0
    }else{
      # compute unadjusted values 
      TauK_unadj[k] = mean(yk[zk == 1]) - mean(yk[zk == 0])
      
      # compute adjusted values
      xk_centered <- scale(xk, scale = FALSE)
      fit_adj   = lm(yk ~ zk + xk_centered + zk * xk_centered)
      TauK_adj[k]   = coef(fit_adj)[2]
      
      # compute difference in means
      dif_means[ , k] <- 
        apply(xk, 2, 
              function(variable){
                if(mean(variable[zk == 1]) - 
                   mean(variable[zk == 0]) == 0 | 
                   length(zk[zk == 1]) == 1 | length(zk[zk == 0]) == 1){
                  1
                }else if(sd(variable[zk == 1]) == 0 & sd(variable[zk == 0]) == 0){
                  0
                }else{
                  t.test(variable[zk == 1],
                         variable[zk == 0])$p.value
                }
              })
    }
  }
  strat_unadj <- sum(PiK*TauK_unadj)
  strat_adj <- sum(PiK*TauK_adj)
  
  # make dataframe of difference in means
  dif_means <- data.frame(dif_means, row.names = colnames(x))
  
  return(list(estimates = c(ace.reg, ace.ipw0, ace.ipw, ace.dr, 
                            strat_unadj, strat_adj), 
              balance = round(dif_means, 3)))   
}


ObsCausal = function(z, y, x, n.boot = 10^2,
                     out.family = gaussian, truncpscore = c(0, 1), 
                     K, quad_out = FALSE, quad_prop = FALSE)
{
  point.est  = ObsCausal.est(z, y, x, out.family, truncpscore, K, 
                             quad_out, quad_prop)$estimates
  
  ## nonparametric bootstrap
  n.sample   = length(z)
  x          = as.matrix(x)
  boot.est   = replicate(n.boot, 
                         {id.boot = sample(1:n.sample, n.sample, replace = TRUE)
                         ObsCausal.est(z[id.boot], y[id.boot], x[id.boot, ], 
                                       out.family, truncpscore, K, 
                                       quad_out, quad_prop)$estimates})
  boot.var   = apply(boot.est, 1, var)
  
  return(cbind(point.est, boot.var))
}

ObsCasualMatch <-  function(z, y, x, num_matches = 1)
{
  ## Abadie-Imbens
  # without bias adjustment
  matchest = Match(Y = y, Tr = z, X = x, M = num_matches)
  tau_match = matchest$est 
  se_tau_match = matchest$se
  
  # compute balance 
  balance = MatchBalance(z ~ x, match.out = matchest, nboots = 100, 
                         print.level = 0)
  
  # with bias adjustment
  matchest.adj = Match(Y = y, Tr = z, X = x, 
                       M = num_matches, BiasAdjust = TRUE)
  tau_match_adj = matchest.adj$est
  se_tau_match_adj = matchest.adj$se
  
  # compute balance 
  balance_adj <- MatchBalance(z ~ x, match.out = matchest.adj, nboots = 100,
                              print.level = 0)
  
  return(list(estimates = cbind(c(tau_match, tau_match_adj), 
                                c(se_tau_match, se_tau_match_adj)),
              balance_unadj = balance,
              balance_adj = balance_adj))
}

# load observational version of the lalonde data
lalonde_obs <- read.table("cps1re74.csv",header=T)
# unemployed
lalonde_obs$u74 <- as.numeric(lalonde_obs$re74==0)
lalonde_obs$u75 <- as.numeric(lalonde_obs$re75==0)

head(lalonde_obs)

y <- lalonde_obs$re78
z <- lalonde_obs$treat
x <- as.matrix(lalonde_obs[, c("age", "educ", "black",
                      "hispan", "married", "nodegree",
                      "re74", "re75", "u74", "u75")])

## analyze as observational
causaleffects = ObsCausal(z, y, x, n.boot = 100, K = 5)

# compute matching estimator
matching_est <- ObsCasualMatch(z, y, x)

# compute confidence 
causaleffects_lalonde <- rbind(causaleffects, matching_est$estimates)
causaleffects_lalonde <- cbind(causaleffects_lalonde[ , 1], 
                               sqrt(causaleffects_lalonde[ , 2]))

rownames(causaleffects_lalonde) <- c("Regression imputation", "IPW 1", "IPW 2", 
                                     "Doubly robust", "Propensity score stratification", 
                                     "Propensity score stratification with regression adj", 
                                     "Uncorrected matching", "Bias-corrected matching")

colnames(causaleffects_lalonde) <- c("Estimate", "Standard error")
causaleffects_lalonde
